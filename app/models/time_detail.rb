class TimeDetail < ApplicationRecord
  belongs_to :part
  belongs_to :fleet
  after_save :insert_alert_life_time, :insert_alert_fluid, :find_out_tbos


  def find_out_tbos
    self.fleet.find_out_tbos
  end
  # Tiempos de vida limite *********************************************************************
  def new_alert_life_time(life_time_limit)
    if AlertLifeLimit.is_accomplished?(self.fleet.id, life_time_limit.id)
      AlertLifeLimit.create(fleet_id: self.fleet.id, life_time_limit_id: life_time_limit.id, state: 'pending')
    end
  end
  def insert_alert_life_time
    self.part.life_time_limits.each do |life_time_limit|
      if life_time_limit.is_in_flight_hours?
        if life_time_limit.is_there_an_alert?(self.fhsn)
          new_alert_life_time(life_time_limit)
        end
      else
        if life_time_limit.is_there_an_alert?(self.dsn)
          new_alert_life_time(life_time_limit)
        end
      end
    end
  end

  # *********************************************************************************************

  # Cambio/lubricación **************************************************************************

  def new_alert_fluid(fluid)
    if AlertFluid.is_accomplished?(self.fleet.id, fluid.id)
      if fluid.unit.name == 'Flight hours'
        if fluid.condition.name == 'TSN'
          AlertFluid.create(fleet_id: self.fleet.id, fluid_id: fluid.id, state: 'pending', limit: ((self.fhsn + fluid.alert_before)/fluid.time_limit).to_i*fluid.time_limit + fluid.over_the_time_limit)
        end
        if fluid.condition.name == 'TSO'
          AlertFluid.create(fleet_id: self.fleet.id, fluid_id: fluid.id, state: 'pending', limit: ((self.fhso + fluid.alert_before)/fluid.time_limit).to_i*fluid.time_limit + fluid.over_the_time_limit)
        end
        if fluid.condition.name == 'No requerido'
          relation1 = self.part.fluids.joins(:unit).where('units.name = ?', 'Flight hours').joins(:condition).where('conditions.name =?', 'TSN')
          relation2 = fluid.part.fluids.joins(:unit).where('units.name = ?', 'Flight hours').joins(:condition).where('conditions.name = ?', 'TSN')
          relation3 = self.part.fluids.joins(:unit).where('units.name = ?', 'Flight hours').joins(:condition).where('conditions.name =?', 'TSO')
          relation4 = fluid.part.fluids.joins(:unit).where('units.name = ?', 'Flight hours').joins(:condition).where('conditions.name = ?', 'TSO')
          if self.overhaul_date < self.date_since_new
            # si existe una condición TSN
            unless relation1.empty?
              AlertFluid.create(fleet_id: self.fleet.id, fluid_id: fluid.id, state: 'pending', limit: (((self.fhsn- relation2.last.time_limit) + fluid.alert_before)/fluid.time_limit).to_i*fluid.time_limit + fluid.over_the_time_limit + relation2.last.time_limit)
            end
          else
            unless relation3.empty?
              AlertFluid.create(fleet_id: self.fleet.id, fluid_id: fluid.id, state: 'pending', limit: (((self.fhso- relation4.last.time_limit) + fluid.alert_before)/fluid.time_limit).to_i*fluid.time_limit + fluid.over_the_time_limit + relation4.last.time_limit)
            end
          end
        end
      end
      if fluid.unit.name == 'Months'
        if fluid.condition.name == 'TSN'
          AlertFluid.create(fleet_id: self.fleet.id, fluid_id: fluid.id, state: 'pending', limit: ((self.date_since_new + fluid.time_limit.to_i.months + fluid.over_the_time_limit.to_i.months) - self.date_since_new  )/(60*60*24))
        end
        if fluid.condition.name == 'TSO'
          AlertFluid.create(fleet_id: self.fleet.id, fluid_id: fluid.id, state: 'pending', limit: ((self.overhaul_date + fluid.time_limit.to_i.months + fluid.over_the_time_limit.to_i.months) - self.overhaul_date)/(60*60*24))
        end
        if fluid.condition.name == 'No requerido'
          relation1 = fluid.part.fluids.joins(:unit).where('units.name = ? ', 'Months').joins(:condition).where('conditions.name = ?', 'TSO')
          relation2 = fluid.part.fluids.joins(:unit).where('units.name = ? ', 'Months').joins(:condition).where('conditions.name = ?', 'TSN')
          relation3 =  AlertFluid.where('alert_fluids.created_at > ?', self.overhaul_date).joins(fluid: :unit).where('units.name = ?', 'Months').joins(fluid: :condition).where('conditions.name = ?', 'TSO')
          relation4 =  AlertFluid.where('alert_fluids.created_at > ?', self.date_since_new).joins(fluid: :unit).where('units.name = ?', 'Months').joins(fluid: :condition).where('conditions.name = ?', 'TSN')
          factor1 = AlertFluid.where('fleet_id = ? AND fluid_id = ? AND created_at > ?', self.fleet.id, fluid.id, self.date_since_new).count + 1
          factor2 = AlertFluid.where('fleet_id = ? AND fluid_id = ? AND created_at > ?', self.fleet.id, fluid.id, self.overhaul_date).count + 1
          if self.overhaul_date < self.date_since_new
            # si existe la condición TSN
            if !relation2.empty?
              # si ya se ha realizado la condición
              unless relation4.empty?
                AlertFluid.create(fleet_id: self.fleet.id,
                                  fluid_id: fluid.id,
                                  state: 'pending',
                                  limit: ((self.date_since_new + relation4.last.fluid.time_limit.to_i.months + (factor1 * fluid.time_limit).to_i.months + fluid.over_the_time_limit.to_i.months)- self.date_since_new) / (60*60*24))
              end
            else
              AlertFluid.create(fleet_id: self.fleet.id,
                                fluid_id: fluid.id,
                                state: 'pending',
                                limit: ((self.date_since_new +  (factor1 * fluid.time_limit).to_i.months + fluid.over_the_time_limit.to_i.months)- self.date_since_new) / (60*60*24))
            end
          else
            # si existe la condición TSO
            if !relation1.empty?
              # si ya se ha realizado la condición
              unless relation4.empty?
                AlertFluid.create(fleet_id: self.fleet.id,
                                  fluid_id: fluid.id,
                                  state: 'pending',
                                  limit: ((self.overhaul_date + relation3.last.fluid.time_limit.to_i.months + (factor2 * fluid.time_limit).to_i.months + fluid.over_the_time_limit.to_i.months)- self.overhaul_date)/ (60*60*24))
              end
            else
              AlertFluid.create(fleet_id: self.fleet.id,
                                fluid_id: fluid.id,
                                state: 'pending',
                                limit: ((self.overhaul_date +  (factor2 * fluid.time_limit).to_i.months + fluid.over_the_time_limit.to_i.months)- self.overhaul_date) / (60*60*24))
            end
          end
        end
      end
    end
  end
  def insert_alert_fluid
    self.part.fluids.each do |fluid|
      if fluid.is_in_flight_hours?
        if fluid.is_there_an_alert?(self)
          new_alert_fluid(fluid)
        end
      else
        if fluid.calendar_time_alert?(self)
          new_alert_fluid(fluid)
        end
      end
    end
  end

  # *********************************************************************************************

  def update_dso
    self.update(dso: self.dso + (Time.zone.today - self.overhaul_date.to_date).to_i)
    # self.update(dso: 1470)
  end
  def update_dsn
    self.update(dsn: self.dsn + (Time.zone.today - self.overhaul_date.to_date).to_i)
    # self.update(dsn: 1470)
  end

  def self.after_tbo(new_state, v_fleet_id, v_part_id)
    record = self.where('fleet_id = ? AND part_id = ?', v_fleet_id, v_part_id).first
    if new_state == 'new'
      record.update(overhaul_state: new_state, fhsn: 0, dsn: 0, date_since_new: DateTime.now)
    end
    if new_state == 'overhauled'
      record.update(overhaul_state: new_state, fhso: 0, dso: 0, overhaul_date: DateTime.now)
    end
  end

  def self.after_change_item(new_state, v_fleet_id, v_part_id)
    record = self.where('fleet_id = ? AND part_id = ?', v_fleet_id, v_part_id).first
    if new_state == 'new'
      record.update(overhaul_state: new_state, fhsn: 0, fhso: -876000, dsn: 0, dso: -36500, overhaul_date: DateTime.now - 100.years , date_since_new: DateTime.now)
    end
  end

  def dsn_in_months
    (Time.zone.today.year * 12 + Time.zone.today.month) - (self.date_since_new.year * 12 + self.date_since_new.month)
  end
  def dso_in_months
    (Time.zone.today.year * 12 + Time.zone.today.month) - (self.overhaul_date.year * 12 + self.overhaul_date.month)
  end

end
