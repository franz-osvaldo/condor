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
      if !(Condition.joins(fluids: :part).where('parts.id = ?', self.part.id).pluck(:name) - ['No requerido']).empty?
        if Condition.joins(fluids: :part).where('parts.id = ?', self.part.id).pluck(:name).include? 'TSN'

          puts '********************************************************************************************************************************************'
          puts time_detail.fhsn
          puts self.part.fluids.joins(:condition).where('conditions.name = ?', 'TSN').joins(:unit).where('units.name = ?', 'Flight hours').first.time_limit
          puts time_detail.fhsn / self.time_limit - 1
          puts self.time_limit
          puts self.alert_before
          puts '********************************************************************************************************************************************'
          if time_detail.fhsn > self.time_limit
            return time_detail.fhsn - self.part.fluids.joins(:condition).where('conditions.name = ?', 'TSN').joins(:unit).where('units.name = ?', 'Flight hours').first.time_limit - (((time_detail.fhsn / self.time_limit).to_i - 1) * self.time_limit) >= self.time_limit - self.alert_before  &&
                   time_detail.fhsn - self.part.fluids.joins(:condition).where('conditions.name = ?', 'TSN').joins(:unit).where('units.name = ?', 'Flight hours').first.time_limit - (((time_detail.fhsn / self.time_limit).to_i - 1) * self.time_limit) <= self.time_limit + self.over_the_time_limit
          end
        end
        if Condition.joins(fluids: :part).where('parts.id = ?', self.part.id).pluck(:name).include? 'TSO'
          if time_detail.fhso > self.time_limit
            return time_detail.fhso - self.part.fluids.joins(:condition).where('conditions.name = ?', 'TSO').joins(:unit).where('units.name = ?', 'Flight hours').first.time_limit - (((time_detail.fhsn / self.time_limit).to_i - 1) * self.time_limit) >= self.time_limit - self.alert_before  &&
                   time_detail.fhso - self.part.fluids.joins(:condition).where('conditions.name = ?', 'TSO').joins(:unit).where('units.name = ?', 'Flight hours').first.time_limit - (((time_detail.fhsn / self.time_limit).to_i - 1) * self.time_limit) <= self.time_limit + self.over_the_time_limit
          end
        end
      else
        return time_detail.fhsn >= self.time_limit - self.alert_before && time_detail.fhsn <= self.time_limit + self.over_the_time_limit
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
      if !Condition.joins(fluids: :part).where('parts.id = ?', self.part.id).empty?
        if Condition.joins(fluids: :part).where('parts.id = ?', self.part.id).pluck(:name).include? 'TSN'
          val = (time_detail.dsn_in_months - self.part.fluids.joins(:condition).where('conditions.name = ?', 'TSN').joins(:unit).where('units.name = ?', 'Months').first.time_limit + self.alert_before) / self.time_limit
          if val >= 1
            return time_detail.dsn_in_months >= self.time_limit * val - self.alert_before && time_detail.dsn_in_months <= self.time_limit * val + self.over_the_time_limit
          end
        end
        if Condition.joins(fluids: :part).where('parts.id = ?', self.part.id).pluck(:name).include? 'TSO'
          val = (time_detail.dso_in_months - self.part.fluids.joins(:condition).where('conditions.name = ?', 'TSO').joins(:unit).where('units.name = ?', 'Months').first.time_limit + self.alert_before) / self.time_limit
          if val >= 1
            return time_detail.dso_in_months >= self.time_limit * val - self.alert_before && time_detail.dso_in_months <= self.time_limit * val + self.over_the_time_limit
          end
        end
      else
        return time_detail.dsn_in_months >= self.time_limit - self.alert_before && time_detail.dsn_in_months <= self.time_limit + self.over_the_time_limit
      end
    end
    false
  end
end

