class Scrapers::Wikipedia::AwardsHugoNovelService < Scrapers::Wikipedia::AwardsBaseService
  URL = "https://en.wikipedia.org/wiki/Hugo_Award_for_Best_Novel"
  AWARD = "Hugo Award"
  CATEGORY = "Best Novel"

  def perform
    super(URL, AWARD, CATEGORY)

    self
  end

  private

  def get_book_url(row)
    puts "XXX: child.get_book_url"
    puts "XXX: row: #{row}"
    field = [row["Novel"]].flatten.first

    puts "XXX: field: #{field}"
    if field && field["link"] && !field["link"].match("redlink=1")
      "#{@base_url}#{field["link"]}"
    end
  end

  def create_book(row, author)
    if row["Novel"]
      Book.find_or_create_by!({
        title: [row["Novel"]].flatten.first["text"].gsub("\"", ""),
        author: author
      })
    end

  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Error Creating Book: #{row}, e: #{e}"
    nil
  end
end
