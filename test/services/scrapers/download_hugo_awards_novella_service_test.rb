require "test_helper"

class Scrapers::DownloadHugoAwardsNovellaServiceTest < ActiveSupport::TestCase
  def test_perform
    VCR.use_cassette("DownloadHugoAwardsNovellaService_test_perform") do
      Scrapers::DownloadHugoAwardsNovellaService.perform
    end
  end
end
