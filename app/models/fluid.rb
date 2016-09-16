class Fluid < ApplicationRecord
  belongs_to :part
  belongs_to :condition
  belongs_to :unit
  belongs_to :tbo, optional: true
  has_many :alert_fluids
  has_many :fleets, through: :alert_fluids

  def is_in_flight_hours?
    self.unit.name == 'Flight hours'
  end

  def is_there_an_alert?(time_detail)
  # consideraciones: condiciones, prioridades
    if self.condition.name == 'TSN'
      return  time_detail.fhsn >= self.time_limit - self.alert_before && time_detail.fhsn <= self.time_limit + self.over_the_time_limit
    end
    if self.condition.name == 'TSO'
      return time_detail.fhso >= self.time_limit - self.alert_before && time_detail.fhso <= self.time_limit + self.over_the_time_limit
    end
    if self.condition.name == 'No requerido'
      val = (time_detail.fhsn + self.alert_before) / self.time_limit
      if val >= 2
        return time_detail.fhsn >= self.time_limit * val - self.alert_before && time_detail.fhsn <= self.time_limit * val + self.over_the_time_limit
      end
    end
    false
  end
  # Estamos suponiendo que los tiempos limite están dados en meses
  def calendar_time_alert?(time_detail)
    if self.condition.name == 'TSN'
      return  time_detail.dsn_in_months >= self.time_limit - self.alert_before && time_detail.dsn_in_months <= self.time_limit + self.over_the_time_limit
    end
    if self.condition.name == 'TSO'
      return time_detail.dso_in_months >= self.time_limit - self.alert_before && time_detail.dso_in_months <= self.time_limit + self.over_the_time_limit
    end
    if self.condition.name == 'No requerido'
      val = (time_detail.dsn_in_months + self.alert_before) / self.time_limit
      if val >= 2
        return time_detail.dsn_in_months >= self.time_limit * val - self.alert_before && time_detail.dsn_in_months <= self.time_limit * val + self.over_the_time_limit
      end
    end
    false
  end
end

