class Aircraft < ApplicationRecord
  has_many :systems
  has_many :fleets
end
