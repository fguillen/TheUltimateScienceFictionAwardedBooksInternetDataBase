class Scrapers::DownloadHugoAwardsNovellaService < ApplicationService
  URL = "https://en.wikipedia.org/wiki/Hugo_Award_for_Best_Novella"
  AWARD = "Hugo_Award"
  CATEGORY = "Best Novella"

  def perform
    award = create_award



    table_rows.each do |row|
      author = create_author(row)
      book = create_book(row, author)

      if !book.nil?
        award_winner = create_award_winner(row, award, book)
      end
    end
  end

  private

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
    puts "row: #{row}"
    if !row["Novella"].nil?
      Book.find_or_create_by!({
        title: row["Novella"]["text"],
        author: author
      })
    end

  rescue ActiveRecord::RecordInvalid
    Rails.logger.error "Duplicate Book: #{row["Novella"]["text"]}, we have to fix this"
    nil
  end

  def create_author(row)
    puts "row: #{row}"
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
