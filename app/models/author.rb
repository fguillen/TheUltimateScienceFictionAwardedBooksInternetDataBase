class Author < ApplicationRecord
  self.primary_key = :slug

  before_validation :initialize_slug

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  private

  def initialize_slug
    self.slug ||= name.parameterize
  end
end
