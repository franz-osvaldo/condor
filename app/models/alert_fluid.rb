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
    if Fluid.find(fluid_id).unit.name == 'Flight hours'
      if Fluid.find(fluid_id).condition.name == 'TSN'
        return true
      end
      if Fluid.find(fluid_id).condition.name == 'TSO'
        return true
      end
      if Fluid.find(fluid_id).condition.name == 'No requerido'
        return true
      end
    end
    if Fluid.find(fluid_id).unit.name == 'Months'
      if Fluid.find(fluid_id).condition.name == 'TSN'
        return true
      end
      if Fluid.find(fluid_id).condition.name == 'TSO'
        return true
      end
      if Fluid.find(fluid_id).condition.name == 'No requerido'
        return true
      end
    end
    false
  end
end
