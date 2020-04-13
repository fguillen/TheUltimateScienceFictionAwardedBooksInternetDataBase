require 'test_helper'

class AwardWinnerTest < ActiveSupport::TestCase
  def test_fixture_is_valid
    assert FactoryBot.create(:award_winner).valid?
  end
end
