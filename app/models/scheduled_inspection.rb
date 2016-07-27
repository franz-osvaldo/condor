class ScheduledInspection < ApplicationRecord
  belongs_to :system
  has_many :priorities, dependent: :destroy
  has_many :inspections, through: :priorities
  has_many :actions, inverse_of: :scheduled_inspection, dependent: :destroy
  accepts_nested_attributes_for :actions

  before_save :mark_addresses_for_removal

  def mark_addresses_for_removal
    actions.each do |action|
      action.mark_for_destruction if action.action.blank?
    end
  end

#   Descripción: Cada una de las inspecciones diferentes registradas
#   Tipo: Método de clase
#   Entradas: ninguna
#   Salida: Un arreglo de los nombres de las inspecciones
  def self.all_inspections
    pluck('DISTINCT name')
  end
#   Descripcion: Todas las inspecciones prioritarias de una determinada inspección programada
#   Tipo: Método de instancia
#   Entradas: ninguna
#   Salida: Un arreglo de los nombres de las inspecciones
  def all_priority_inspections
    inspections.pluck(:name)
  end
#   Descripción: Tiempo limite de una determinada inspección
#   Tipo: Método de instancia
#   Entradas: El nombre de una unidad
#   Salida: Un arreglo de los tiempos limite ([400, 800])
  def time_limit(unit_name)
    arreglo = []
    actions.each do |action|
      action.time_limits.each do |time_limit|
        if time_limit.unit.name == unit_name
          arreglo.push(time_limit.time )
        end
      end
    end
    arreglo.uniq
  end
#   Descripción: Todos los tiempos limite de una determinada inspección antes de un tiempo dado, suponiendo que no existen inspecciones prioritarias
#   Tipo:        Método de instancia
#   Entradas:    Un tiempo y su unidad
#   Salida:      Arreglo de tiempos limite([50, 100, 150....tiempo_dado])
  def all_time_limits(time, unit_name)
    arreglo = []
    time_limit(unit_name).each do |time_limit|
      (1..time).each do |t|
        if t % time_limit == 0
          arreglo.push(t)
        end
      end
    end
    arreglo.uniq.sort
  end
#   Descripción: Todos los tiempos limite de una determinada inspección antes de un tiempo dado, suponiendo que existen inspecciones prioritarias
#   Tipo:        Método de instancia
#   Entradas:    Un tiempo y la unidad del tiempo
#   Salida:      Arreglo de tiempos limite([50, 150, 250....tiempo_dado])
  def time_limits(time, unit_name)
    arreglo = all_time_limits(time, unit_name)
    all_priority_inspections.each do |name_inspection|
      arreglo = arreglo - ScheduledInspection.where('system_id = ? AND name = ?', system_id, name_inspection).first.all_time_limits(time, unit_name)
    end
    arreglo
  end
end
