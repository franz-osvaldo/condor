class Part < ApplicationRecord
  belongs_to :component
  has_many :time_details
  has_many :fleets, through: :time_details
  has_many :tbos
  has_many :fluids
  has_many :life_time_limits
end
