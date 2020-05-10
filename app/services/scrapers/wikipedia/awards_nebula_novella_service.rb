class Scrapers::Wikipedia::AwardsNebulaNovellaService < Scrapers::Wikipedia::AwardsBaseService
  URL = "https://en.wikipedia.org/wiki/Nebula_Award_for_Best_Novella"
  AWARD = "Nebula Award"
  CATEGORY = "Best Novella"

  def perform
    super(URL, AWARD, CATEGORY)

    self
  end

  private

  def get_book_url(row)
    puts "XXX: row: #{row}"
    field = [row["Novella"]].flatten.first
    if field && field["link"] && !field["link"].match("redlink=1")
      "#{@base_url}#{field["link"]}"
    end
  end

  def create_author(row)
    Author.find_or_create_by!({
      name: [row["Author"]].flatten.first["text"]
    })
  end

  def create_book(row, author)
    if row["Novella"]
      Book.find_or_create_by!({
        title: [row["Novella"]].flatten.first["text"].gsub("\"", ""),
        author: author
      })
    end

  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Error Creating Book: #{row}, e: #{e}"
    nil
  end
end
