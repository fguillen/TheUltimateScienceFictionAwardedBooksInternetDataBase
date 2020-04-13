class Scrapers::DownloadHugoAwardsNovellaService < ApplicationService
  URL = "https://en.wikipedia.org/wiki/Hugo_Award_for_Best_Novella"

  def perform
    table = Wac::Page.new(URL).extract[:tables].first
  end
end
