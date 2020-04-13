require 'test_helper'

class AwardTest < ActiveSupport::TestCase
  def test_fixture_is_valid
    assert FactoryBot.create(:award).valid?
  end

  def test_slug_on_create
    award = FactoryBot.build(:award, name: "Award Name", category: "Category Name")
    assert_nil(award.slug)

    award.save!

    assert_equal("award-name-category-name", award.slug)
  end

  def test_primary_key
    award = FactoryBot.create(:award)

    assert_equal(award, Award.find(award.slug))
  end
end
