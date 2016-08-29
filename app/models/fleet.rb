class Fleet < ApplicationRecord
  belongs_to :aircraft
  has_many :flights
  has_many :time_details
  has_many :parts, through: :time_details
  after_create :set_time_details
  def total_flight_hours
    self.flights.sum(:flight_time)
  end

  def my_parts
    Part.joins(component: [{system: [{aircraft: :fleets}]}]).where('fleets.id' => self.id)
  end

  def set_time_details
    self.my_parts.each do |part|
      TimeDetail.create(part_id: part.id,
                        fleet_id: self.id,
                        fhsn: 0,
                        dsn: 0,
                        fhso: 0,
                        dso: 0,
                        overhaul_state: 'original',
                        overhaul_date: DateTime.now)
    end
  end
end
