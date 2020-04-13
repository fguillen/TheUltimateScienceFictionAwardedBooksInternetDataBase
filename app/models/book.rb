class Book < ApplicationRecord
  self.primary_key = :slug

  belongs_to :author

  before_validation :initialize_slug

  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  private

  def initialize_slug
    self.slug ||= title.parameterize
  end
end
