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
    if self.condition.name == 'TSN' && time_detail.date_since_new > time_detail.overhaul_date
      # Si es la primera vez
      if self.alert_fluids.where('created_at > ?', time_detail.date_since_new).empty?
        return  time_detail.fhsn >= self.time_limit - self.alert_before && time_detail.fhsn <= self.time_limit + self.over_the_time_limit
      end
    end
    if self.condition.name == 'TSO' && time_detail.date_since_new < time_detail.overhaul_date
      if self.alert_fluids.where('created_at > ?', time_detail.overhaul_date).empty?
        return time_detail.fhso >= self.time_limit - self.alert_before && time_detail.fhso <= self.time_limit + self.over_the_time_limit
      end
    end
    if self.condition.name == 'No requerido'
      relation1 = self.part.fluids.joins(:unit).where('units.name = ? ', 'Flight hours').joins(:condition).where('conditions.name = ?', 'TSO')
      relation2 = self.part.fluids.joins(:unit).where('units.name = ? ', 'Flight hours').joins(:condition).where('conditions.name = ?', 'TSN')
      relation3 =  AlertFluid.where('alert_fluids.created_at > ?', time_detail.overhaul_date).joins(fluid: :unit).where('units.name = ?', 'Flight hours').joins(fluid: :condition).where('conditions.name = ?', 'TSO')
      relation4 =  AlertFluid.where('alert_fluids.created_at > ?', time_detail.date_since_new).joins(fluid: :unit).where('units.name = ?', 'Flight hours').joins(fluid: :condition).where('conditions.name = ?', 'TSN')
      if time_detail.overhaul_date > time_detail.date_since_new
        #  Si existe una condición TSO
        if !relation1.empty?
          # Si la condición ya se realizo
          unless relation3.empty?
            return  (((time_detail.fhso - relation3.last.fluid.time_limit) % self.time_limit >= 0 && (time_detail.fhso - relation3.last.fluid.time_limit) % self.time_limit <= self.over_the_time_limit) ||
                    ((time_detail.fhso - relation3.last.fluid.time_limit) % self.time_limit >= self.time_limit - self.alert_before && (time_detail.fhso - relation3.last.fluid.time_limit) % self.time_limit <= self.time_limit)) &&
                    (time_detail.fhso > relation1.last.time_limit + relation1.last.over_the_time_limit) &&
                    (time_detail.fhso > (AlertFluid.where('fleet_id = ? AND fluid_id = ? AND created_at > ?', time_detail.fleet.id ,self.id, time_detail.overhaul_date).empty? ? 0 : AlertFluid.where('fleet_id = ? AND fluid_id = ? AND created_at > ?', time_detail.fleet.id ,self.id, time_detail.overhaul_date).last.limit))
          end
        else
          return  (time_detail.fhso  % self.time_limit >= 0 && time_detail.fhso  % self.time_limit <= self.over_the_time_limit) ||
              (time_detail.fhso % self.time_limit >= self.time_limit - self.alert_before && time_detail.fhso% self.time_limit <= self.time_limit)
        end
      end
      if time_detail.overhaul_date < time_detail.date_since_new
        # si existe la condición TSN
        if !relation2.empty?
          # si ya se ha realizado la condición
          unless relation4.empty?

            return  (((time_detail.fhsn - relation4.last.fluid.time_limit) % self.time_limit >= 0 && (time_detail.fhsn - relation4.last.fluid.time_limit) % self.time_limit <= self.over_the_time_limit) ||
                ((time_detail.fhsn - relation4.last.fluid.time_limit) % self.time_limit >= self.time_limit - self.alert_before && (time_detail.fhsn - relation4.last.fluid.time_limit) % self.time_limit <= self.time_limit)) &&
                (time_detail.fhsn > relation2.last.time_limit + relation2.last.over_the_time_limit)&&
                (time_detail.fhsn > (AlertFluid.where('fleet_id = ? AND fluid_id = ? AND created_at > ?', time_detail.fleet.id ,self.id, time_detail.date_since_new).empty? ? 0:AlertFluid.where('fleet_id = ? AND fluid_id = ? AND created_at > ?', time_detail.fleet.id ,self.id, time_detail.date_since_new).last.limit))
          end
        else
          return  (time_detail.fhsn  % self.time_limit >= 0 && time_detail.fhsn  % self.time_limit <= self.over_the_time_limit) ||
              (time_detail.fhsn % self.time_limit >= self.time_limit - self.alert_before && time_detail.fhsn% self.time_limit <= self.time_limit)
        end
      end
    end
    false
  end
  # Estamos suponiendo que los tiempos limite están dados en meses
  def calendar_time_alert?(time_detail)

    if self.condition.name == 'TSN' && time_detail.date_since_new > time_detail.overhaul_date
      # Si es la primera vez
      if self.alert_fluids.where('created_at > ?', time_detail.date_since_new).empty?
        return  (time_detail.date_since_new + time_detail.dsn.days >= time_detail.date_since_new + self.time_limit.to_i.months - self.alert_before.to_i.months) && (time_detail.date_since_new + time_detail.dsn.days <= time_detail.date_since_new + self.time_limit.to_i.months + self.over_the_time_limit.to_i.months)
      end
    end
    if self.condition.name == 'TSO' && time_detail.date_since_new < time_detail.overhaul_date
      if self.alert_fluids.where('created_at > ?', time_detail.overhaul_date).empty?
        return  (time_detail.overhaul_date + time_detail.dso.days >= time_detail.overhaul_date + self.time_limit.to_i.months - self.alert_before.to_i.months) && (time_detail.overhaul_date + time_detail.dso.days <= time_detail.overhaul_date + self.time_limit.to_i.months + self.over_the_time_limit.to_i.months)
      end
    end
    if self.condition.name == 'No requerido'
      relation1 = self.part.fluids.joins(:unit).where('units.name = ? ', 'Months').joins(:condition).where('conditions.name = ?', 'TSO')
      relation2 = self.part.fluids.joins(:unit).where('units.name = ? ', 'Months').joins(:condition).where('conditions.name = ?', 'TSN')
      relation3 =  AlertFluid.where('alert_fluids.created_at > ?', time_detail.overhaul_date).joins(fluid: :unit).where('units.name = ?', 'Months').joins(fluid: :condition).where('conditions.name = ?', 'TSO')
      relation4 =  AlertFluid.where('alert_fluids.created_at > ?', time_detail.date_since_new).joins(fluid: :unit).where('units.name = ?', 'Months').joins(fluid: :condition).where('conditions.name = ?', 'TSN')
      factor1 = AlertFluid.where('fleet_id = ? AND fluid_id = ? AND created_at > ?', time_detail.fleet.id, self.id, time_detail.date_since_new).count + 1
      factor2 = AlertFluid.where('fleet_id = ? AND fluid_id = ? AND created_at > ?', time_detail.fleet.id, self.id, time_detail.overhaul_date).count + 1
      if time_detail.overhaul_date > time_detail.date_since_new
        #  Si existe una condición TSO
        if !relation1.empty?
          # Si la condición ya se realizo
          unless relation3.empty?
            return (time_detail.overhaul_date + time_detail.dso.days >=
                   time_detail.overhaul_date +  relation3.last.fluid.time_limit.to_i.months + (factor2 * self.time_limit.to_i).months - self.alert_before.to_i.months) &&
                   (time_detail.overhaul_date + time_detail.dso.days <=
                   time_detail.overhaul_date +  relation3.last.fluid.time_limit.to_i.months + (factor2 * self.time_limit.to_i).months + self.over_the_time_limit.to_i.months)
          end
        else
          return (time_detail.overhaul_date + time_detail.dso.days >=
                 time_detail.overhaul_date +  (factor2 * self.time_limit.to_i).months - self.alert_before.to_i.months) &&
                 (time_detail.overhaul_date + time_detail.dso.days <=
                 time_detail.overhaul_date +  (factor2 * self.time_limit.to_i.months) + self.over_the_time_limit.to_i.months)
        end
      end
      if time_detail.overhaul_date < time_detail.date_since_new
        # si existe la condición TSN
        if !relation2.empty?
          # si ya se ha realizado la condición
          unless relation4.empty?
            return (time_detail.date_since_new + time_detail.dsn.days >=
                   time_detail.date_since_new +  relation4.last.fluid.time_limit.to_i.months + (factor1 * self.time_limit.to_i).months - self.alert_before.to_i.months) &&
                   (time_detail.date_since_new + time_detail.dsn.days <=
                   time_detail.date_since_new +  relation4.last.fluid.time_limit.to_i.months + (factor1 * self.time_limit.to_i).months + self.over_the_time_limit.to_i.months)
          end
        else
          return (time_detail.date_since_new + time_detail.dsn.days >=
                 time_detail.date_since_new +  (factor1 * self.time_limit.to_i).months - self.alert_before.to_i.months) &&
                 (time_detail.date_since_new + time_detail.dsn.days <=
                 time_detail.date_since_new +  (factor1 * self.time_limit.to_i.months) + self.over_the_time_limit.to_i.months)
        end
      end
    end
    false
  end
end

