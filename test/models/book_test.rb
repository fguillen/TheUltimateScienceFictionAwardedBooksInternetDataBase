require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def test_fixture_is_valid
    assert FactoryBot.create(:book).valid?
  end

  def test_slug_on_create
    book = FactoryBot.build(:book, title: "Book Title")
    assert_nil(book.slug)

    book.save!

    assert_equal("book-title", book.slug)
  end

  def test_primary_key
    book = FactoryBot.create(:book)

    assert_equal(book, Book.find(book.slug))
  end

  def test_author_reference
    author = FactoryBot.create(:author)
    book = FactoryBot.create(:book, author: author)

    assert_equal(author, book.author)
  end
end
