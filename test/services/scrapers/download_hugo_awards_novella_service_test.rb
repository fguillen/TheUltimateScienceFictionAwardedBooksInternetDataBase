require "test_helper"

class Scrapers::DownloadHugoAwardsNovellaServiceTest < ActiveSupport::TestCase
  def test_perform
    Scrapers::ExtractBookInformationService.expects(:perform).at_least_once

    VCR.use_cassette("DownloadHugoAwardsNovellaService_test_perform") do
      Scrapers::DownloadHugoAwardsNovellaService.perform
    end
  end

  # def test_perform_simple
  #   table = JSON.parse(read_fixture("table_hugo_awards_novella_1968.json"))
  #   Scrapers::DownloadHugoAwardsNovellaService.any_instance.expects(:table_rows).returns(table)

  #   Scrapers::DownloadHugoAwardsNovellaService.perform

  #   puts "books: #{Book.count}"
  #   puts "book: #{Book.first.title}"
  # end
end
