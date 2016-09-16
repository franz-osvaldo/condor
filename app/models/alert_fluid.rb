class AlertFluid < ApplicationRecord
  belongs_to :fleet
  belongs_to :fluid

  def self.is_not_there_a_record?(fleet_id, fluid_id)
    self.where('fleet_id = ? AND fluid_id = ?', fleet_id, fluid_id).empty?
  end

  # Retorna true si no existe el registro o si existe y su estado es accomplished
  # o si existe pero sus unidades son diferentes
  def self.is_accomplished?(fleet_id, fluid_id)
    if self.is_not_there_a_record?(fleet_id, fluid_id)
      return true
    end
    self.where('fleet_id = ? AND fluid_id = ?', fleet_id, fluid_id).last.state == 'accomplished'
    # ||
    #     !Unit.joins(fluid: :alert_fluid)
    #          .where('fleet_id = ? AND fluid_id = ?', fleet_id, fluid_id)
    #          .pluck(:name).include?(Fluid.find(fluid_id).unit.name)
  end
end
