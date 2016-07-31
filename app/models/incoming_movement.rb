class IncomingMovement < ApplicationRecord
  belongs_to :incoming_movement_type
  belongs_to :supplier
  has_many :incoming_details
  has_many :products, through: :incoming_details
end
