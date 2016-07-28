class Passenger < ApplicationRecord
  belongs_to :flight, inverse_of: :passengers
end
