class AlertLifeLimit < ApplicationRecord
  belongs_to :life_time_limit
  belongs_to :fleet
  after_update :update_time_details

  def self.is_not_there_a_record?(fleet_id, life_time_limit_id)
    self.where('fleet_id = ? AND life_time_limit_id = ?', fleet_id, life_time_limit_id).empty?
  end

  # Retorna true si no existe el registro o si existe y su estado es accomplished
  def self.is_accomplished?(fleet_id, life_time_limit_id)
    if self.is_not_there_a_record?(fleet_id, life_time_limit_id)
      return true
    end
    self.where('fleet_id = ? AND life_time_limit_id = ?', fleet_id, life_time_limit_id).last.state == 'accomplished' ||
    !Unit.joins(life_time_limits: :alert_life_limits)
        .where('fleet_id = ? AND life_time_limit_id = ?', fleet_id, life_time_limit_id)
        .pluck(:name).include?(LifeTimeLimit.find(life_time_limit_id).unit.name)
  end

  def update_state(new_state)
    AlertLifeLimit
        .where('state = ?', 'pending')
        .joins(life_time_limit: :part)
        .where('parts.id = ?', self.life_time_limit.part.id).each do |alert_life_limit|
      alert_life_limit.update_attribute(:state, new_state)
    end
  end

  def update_time_details
    TimeDetail.after_change_item('new', self.fleet.id, self.life_time_limit.part.id)
  end
end
