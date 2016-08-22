class Supplier < ApplicationRecord
  has_many :incoming_movements
  validates :supplier, presence: true
end

