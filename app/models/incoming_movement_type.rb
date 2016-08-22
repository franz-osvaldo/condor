class IncomingMovementType < ApplicationRecord
  has_many :incoming_movements
  validates :movement_type, presence: true
end


