class Unit < ApplicationRecord
  has_many :time_limits
  has_many :over_the_time_limits
  has_many :tbos
  has_many :fluids
  has_many :life_time_limits
end
