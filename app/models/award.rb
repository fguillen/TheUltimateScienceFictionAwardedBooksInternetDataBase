class Award < ApplicationRecord
  self.primary_key = :slug

  before_validation :initialize_slug

  validates :name, presence: true
  validates :category, presence: true
  validates :slug, presence: true, uniqueness: true

  private

  def initialize_slug
    self.slug ||= "#{name}-#{category}".parameterize
  end
end
