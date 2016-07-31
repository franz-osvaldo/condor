class Product < ApplicationRecord
  belongs_to :product_unit
  has_many :incoming_details
  has_many :incoming_movements, through: :incoming_details
end


