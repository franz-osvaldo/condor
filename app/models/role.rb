class Role < ApplicationRecord
  belongs_to :flight_crew
  belongs_to :flight
end
