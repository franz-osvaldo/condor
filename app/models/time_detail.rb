class TimeDetail < ApplicationRecord
  belongs_to :part
  belongs_to :fleet

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
      record.update(overhaul_state: new_state, fhsn: 0, fhso: 0, dsn: 0, dso: 0, overhaul_date: Time.zone.today)
    end
    if new_state == 'overhauled'
      record.update(overhaul_state: new_state, fhso: 0, dso: 0, overhaul_date: Time.zone.today)
    end
  end
end
