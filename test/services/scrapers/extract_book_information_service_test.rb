require "test_helper"

class Scrapers::ExtractBookInformationServiceTest < ActiveSupport::TestCase
  def test_perform
    url = "https://en.wikipedia.org/wiki/The_Moon_Goddess_and_the_Son"
    book = FactoryBot.create(:book)

    VCR.use_cassette("ExtractBookInformationService_test_perform") do
      Scrapers::ExtractBookInformationService.perform(url, book)
    end

    puts book.inspect
  end

  # def test_perform_simple
  #   table = JSON.parse(read_fixture("table_hugo_awards_novella_1968.json"))
  #   Scrapers::ExtractBookInformationService.any_instance.expects(:table_rows).returns(table)

  #   Scrapers::ExtractBookInformationService.perform

  #   puts "books: #{Book.count}"
  #   puts "book: #{Book.first.title}"
  # end
end
