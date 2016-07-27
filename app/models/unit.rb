class Unit < ApplicationRecord
  has_many :time_limits
  has_many :over_the_time_limits
end
