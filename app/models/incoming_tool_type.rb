class IncomingToolType < ApplicationRecord
  has_many :incoming_tools
  validates :movement_type, presence: true
end

