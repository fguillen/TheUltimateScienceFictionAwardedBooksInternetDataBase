class Scrapers::Wikipedia::AwardsBaseService < ApplicationService
  def perform(url, award_name, category_name)
    @url = url
    @base_url = base_url(url)

    award = create_award(award_name, category_name)
    books = []

    table_rows.each do |row|
      author = create_author(row)
      book = create_book(row, author)
      book_url = get_book_url(row)

      if book_url.nil?
        puts "Book URL nil: #{row}"
      end

      if book
        create_award_winner(row, award, book)
      end

      if book.nil?
        puts "Book nil: #{row}, #{author.name}"
      end

      if book && book_url
        Scrapers::Wikipedia::ExtractBookInformationService.perform(book_url, book)
      end

      if book
        books << book
      end
    end

    @success = true
    @result = books

    self
  end

  def result
    @result
  end

  def success?
    !!@success
  end

  private

  def get_book_url(row)
    puts "XXX: super.get_book_url"
    if row["Novella"] && row["Novella"]["link"] && !row["Novella"]["link"].match("redlink=1")
      "#{@base_url}#{row["Novella"]["link"]}"
    end
  end

  def table_rows
    Wac::Page.new(@url).extract["tables"].first.rows
  end

  def create_award(award_name, category_name)
    Award.find_or_create_by!({
      name: award_name,
      category: category_name
    })
  end

  def create_book(row, author)
    if row["Novella"]
      Book.find_or_create_by!({
        title: row["Novella"]["text"].gsub("\"", ""),
        author: author
      })
    end

  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Error Creating Book: #{row}, e: #{e}"
    nil
  end

  def create_author(row)
    Author.find_or_create_by!({
      name: [row["Author(s)"]].flatten.first["text"]
    })
  end

  def create_award_winner(row, award, book)
    if(
      row["Author(s)"].is_a?(Array) &&
      row["Author(s)"][1] &&
      row["Author(s)"][1]["text"] == "*"
    )
      position = "winner"
    else
      position = "nominated"
    end

    AwardWinner.find_or_create_by!({
      award: award,
      book: book,
      position: position,
      year: [row["Year"]].flatten.first["text"].to_i
    })
  rescue ActiveRecord::RecordInvalid => e
    puts "XXX: e: #{e.message}"
    if e.message == "Validation failed: Award has already been taken"
      Rails.logger.error "Error Award: #{row}, e: #{e}"
      nil
    else
      raise e
    end
  end

  def base_url(url)
    uri = URI.parse(url)
    "#{uri.scheme}://#{uri.host}"
  end
end
