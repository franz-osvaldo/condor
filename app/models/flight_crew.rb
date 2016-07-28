class FlightCrew < ApplicationRecord
  has_many :roles
  has_many :flights, through: :roles
end
