class TimeDetail < ApplicationRecord
  belongs_to :part
  belongs_to :fleet
  after_save :insert_alert_life_time, :insert_alert_fluid



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
      AlertFluid.create(fleet_id: self.fleet.id, fluid_id: fluid.id, state: 'pending')
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
      record.update(overhaul_state: new_state, fhsn: 0, fhso: 0, dsn: 0, dso: 0, overhaul_date: Time.zone.today, date_since_new: Time.zone.today)
    end
    if new_state == 'overhauled'
      record.update(overhaul_state: new_state, fhso: 0, dso: 0, overhaul_date: Time.zone.today)
    end
  end

  def self.after_change_item(new_state, v_fleet_id, v_part_id)
    record = self.where('fleet_id = ? AND part_id = ?', v_fleet_id, v_part_id).first
    if new_state == 'new'
      record.update(overhaul_state: new_state, fhsn: 0, fhso: 0, dsn: 0, dso: 0, overhaul_date: Time.zone.today, date_since_new: Time.zone.today)
    end
  end

  def dsn_in_months
    (Time.zone.today.year * 12 + Time.zone.today.month) - (self.date_since_new.year * 12 + self.date_since_new.month)
  end
  def dso_in_months
    (Time.zone.today.year * 12 + Time.zone.today.month) - (self.overhaul_date.year * 12 + self.overhaul_date.month)
  end

end
