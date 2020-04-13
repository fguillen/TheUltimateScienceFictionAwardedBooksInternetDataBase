require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  def test_test
    assert true
  end

  def test_fixture_is_valid
    assert FactoryBot.create(:author).valid?
  end

  def test_slug_on_create
    author = FactoryBot.build(:author, name: "Author Name")
    assert_nil(author.slug)

    author.save!

    assert_equal("author-name", author.slug)
  end

  def test_primary_key
    author = FactoryBot.create(:author)

    assert_equal(author, Author.find(author.slug))
  end
end
