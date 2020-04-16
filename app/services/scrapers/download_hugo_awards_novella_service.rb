class Scrapers::DownloadHugoAwardsNovellaService < ApplicationService
  BASE_URL = "https://en.wikipedia.org"
  URL = "https://en.wikipedia.org/wiki/Hugo_Award_for_Best_Novella"
  AWARD = "Hugo_Award"
  CATEGORY = "Best Novella"

  def perform
    award = create_award
    books = []

    table_rows.each do |row|
      author = create_author(row)
      book = create_book(row, author)
      book_url = get_book_url(row)

      if book
        award_winner = create_award_winner(row, award, book)
      end

      if book.nil?
        puts "Book nil: #{row}, #{author.name}"
      end

      if book && book_url
        Scrapers::ExtractBookInformationService.perform(book_url, book)
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
    if row["Novella"] && row["Novella"]["link"] && !row["Novella"]["link"].match("redlink=1")
      "#{BASE_URL}#{row["Novella"]["link"]}"
    end
  end

  def table_rows
    Wac::Page.new(URL).extract["tables"].first.rows
  end

  def create_award
    Award.find_or_create_by!({
      name: AWARD,
      category: CATEGORY
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
      year: row["Year"]["text"].to_i
    })
  end
end
