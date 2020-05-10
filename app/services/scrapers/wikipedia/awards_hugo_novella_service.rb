class Scrapers::Wikipedia::AwardsHugoNovellaService < Scrapers::Wikipedia::AwardsBaseService
  URL = "https://en.wikipedia.org/wiki/Hugo_Award_for_Best_Novella"
  AWARD = "Hugo Award"
  CATEGORY = "Best Novella"

  def perform
    super.perform(URL, AWARD, CATEGORY)

    self
  end

  private

  def get_book_url(row)
    if row["Novella"] && row["Novella"]["link"] && !row["Novella"]["link"].match("redlink=1")
      "#{@base_url}#{row["Novella"]["link"]}"
    end
  end
end
