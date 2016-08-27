class Fleet < ApplicationRecord
  belongs_to :aircraft
  has_many :flights

  def total_flight_hours
    self.flights.sum(:flight_time)
  end
end
