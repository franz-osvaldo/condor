class Tbo < ApplicationRecord
  belongs_to :part
  belongs_to :condition
  belongs_to :unit
  has_many :alert_tbos
  has_many :fleets, through:  :alert_tbos
  has_one :fluid

  # si los tiempos están en años
  def alert_before_in_days
    self.alert_before * 365
  end

  def time_limit_in_days
    self.time_limit * 365
  end

  def over_the_time_limit_in_days
    self.over_the_time_limit * 365
  end
end
