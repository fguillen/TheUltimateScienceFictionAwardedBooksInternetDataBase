class Book < ApplicationRecord
  self.primary_key = :slug

  belongs_to :author

  before_validation :initialize_slug

  validates :title, presence: true, uniqueness: {scope: :author}
  validates :slug, presence: true, uniqueness: true
  validates :author, presence: true

  private

  def initialize_slug
    self.slug ||= title.parameterize
  end
end
