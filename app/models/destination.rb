class Destination < ApplicationRecord
  serialize :references
  serialize :categories

  has_many :products

  validates :name, presence: true
end
