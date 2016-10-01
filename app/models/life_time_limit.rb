class LifeTimeLimit < ApplicationRecord
  belongs_to :part
  belongs_to :unit
  has_many :alert_life_limits
  has_many :fleets, through: :alert_life_limits

  def is_in_flight_hours?
    self.unit.name == 'Flight hours'
  end

  def time_interval
    self.life_limit_in_days - self.alert_before_in_days
  end

  def is_there_an_alert?(time)
    self.time_interval <= time
  end

  def life_limit_in_days
    if self.unit.name == 'Years'
      return self.life_limit * 365
    end
    self.life_limit
  end

  def alert_before_in_days
    if self.unit.name == 'Years'
      return self.alert_before * 365
    end
    self.alert_before
  end

end
