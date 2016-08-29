class Flight < ApplicationRecord
  belongs_to :fleet
  has_many :passengers, inverse_of: :flight, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :flight_crews, through: :roles
  accepts_nested_attributes_for :passengers
  before_save :set_flight_time, :set_block_time, :mark_passengers_for_removal
  after_create :update_time_details
  before_update :re_update_time_details

  private
  def mark_passengers_for_removal
    passengers.each do |passenger|
      passenger.mark_for_destruction if passenger.name.blank?
    end
  end
  def set_flight_time
    if takeoff_time > landing_time
      self.flight_time = ((takeoff_time.end_of_day - takeoff_time).round + (landing_time.hour*60*60 + landing_time.min*60) ) / 3600.0
    else
      self.flight_time = (landing_time - takeoff_time) / 3600.0
    end
  end
  def set_block_time
    if departure_time > arrival_time
      self.block_time = ((departure_time.end_of_day - departure_time).round + (arrival_time.hour*60*60 + arrival_time.min*60) ) / 3600.0
    else
      self.block_time = (arrival_time - departure_time) / 3600.0
    end
  end

  def update_time_details
    self.fleet.time_details.each do |time_detail|
      if time_detail.overhaul_state != 'original'
        time_detail.update(fhsn: time_detail.fhsn + self.flight_time, fhso: time_detail.fhso + self.flight_time)
        time_detail.update_dso
        time_detail.update_dsn
      else
        time_detail.update(fhsn: time_detail.fhsn + self.flight_time)
        time_detail.update_dsn
      end
    end
  end
  def re_update_time_details
    self.fleet.time_details.each do |time_detail|
      if time_detail.overhaul_state != 'original'
        time_detail.update(fhsn: time_detail.fhsn - Flight.find(self.id).flight_time + self.flight_time, fhso: time_detail.fhso - Flight.find(self.id).flight_time + self.flight_time)
      else
        time_detail.update(fhsn: time_detail.fhsn - Flight.find(self.id).flight_time + self.flight_time)
      end
    end
  end
end

