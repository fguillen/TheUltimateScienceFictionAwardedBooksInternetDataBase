class AwardWinner < ApplicationRecord
  POSITIONS = ["winner", "nominated"]

  belongs_to :award
  belongs_to :book

  validates :award_id, uniqueness: { scope: :book_id }
  validates :award_id, presence: true
  validates :book_id, presence: true
  validates :year, presence: true, numericality: { only_integer: true }
  validates :position, presence: true, inclusion: { in: POSITIONS }
end
