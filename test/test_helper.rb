ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "mocha/minitest"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  def read_fixture(fixture_file)
    File.read("#{__dir__}/fixtures/#{fixture_file}")
  end

  def write_fixture(fixture_file, content)
    File.open("#{__dir__}/fixtures/#{fixture_file}", "w") do |f|
      f.write content
    end
  end
end


# vcr
VCR.configure do |config|
  config.cassette_library_dir = "#{__dir__}/fixtures/vcr_cassettes"
  config.hook_into :webmock
end
