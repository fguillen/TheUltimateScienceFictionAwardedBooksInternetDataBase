class Scrapers::Wikipedia::ExtractBookInformationService < ApplicationService
  def initialize(url, book)
    @url = url
    @book = book
  end

  def perform
    info = get_info(@url)

    update_book(@book, info) if info

    @success = true
    @result = @book

    self
  end

  def result
    @result
  end

  def success?
    !!@success
  end

  private

  def clean_value(value)
    if value
      [value].flatten.first["text"]
    end
  end

  def get_info(url)
    puts "url: #{url}"
    puts Wac::Page.new(url).extract.to_hash

    card = Wac::Page.new(url).extract.to_hash["cards"].first

    if card
      content = Wac::Page.new(url).extract.to_hash["cards"].first.to_hash["content"]

      {
        country: clean_value(content["Country"]),
        language: clean_value(content["Language"]),
        publication_date: clean_value(content["Publication date"]),
        pages: clean_value(content["Pages"]).to_i,
        isbn: clean_value(content["ISBN"])
      }
    end
  end

  def update_book(book, info)
    book.update_attributes!(info)
  end
end
