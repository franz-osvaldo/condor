class TimeDetail < ApplicationRecord
  belongs_to :part
  belongs_to :fleet
  after_update :update_dsn
  after_update :update_dso, if: -> {overhaul_state != 'original'}

  def update_dso
    self.update(dsn: self.dso + (Time.zone.today - self.overhaul_date.to_date).to_i)
  end
  def update_dsn
    self.update(dsn: self.dsn + (Time.zone.today - self.overhaul_date.to_date).to_i)
  end
end
