class OutgoingToolType < ApplicationRecord
  has_many :outgoing_tools
  validates :movement_type, presence: true
end


