class Product < ApplicationRecord
  belongs_to :product_unit
  has_many :incoming_details
  has_many :incoming_movements, through: :incoming_details
  has_many :outgoing_details
  has_many :outgoing_movements, through: :outgoing_details
  has_many :product_quantities
end



