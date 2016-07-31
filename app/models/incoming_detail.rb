class IncomingDetail < ApplicationRecord
  belongs_to :incoming_movement
  belongs_to :product
end
