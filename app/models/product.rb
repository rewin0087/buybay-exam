class Product < ApplicationRecord
  belongs_to :destination, optional: true

  validates :name, :reference, :category, :price, presence: true

  scope :routed, -> { where.not(destination_id: nil) }
  scope :unrouted, -> { where(destination_id: nil) }

  def self.categories
    pluck(:category).uniq.sort
  end

  def self.references
    pluck(:reference).uniq.sort
  end

  def assign_route!
    ::RouteProduct.new(self).call
  end
end
