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

  # Todas las inspecciones sin tomar en cuenta prioritarias ni condiciones
  # [[#<TimeLimit...>, current_time, time_limit, condition_name, inspection_name], []... ]
  def self.all_inspections(end_time, system_id, unit_name)
    arreglo = []
    scheduled_inspections = ScheduledInspection.where('system_id = ?', system_id)
    (1..end_time).each do |i|
      scheduled_inspections.each do |scheduled_inspection|
        scheduled_inspection.actions.each do |action|
          action.time_limits.each do |time_limit|
            if time_limit.unit.name  == unit_name
              arreglo.push([time_limit,i, time_limit.time ,time_limit.inspection.name, time_limit.action.scheduled_inspection.name]) if i % time_limit.time == 0
            end
          end
        end
      end
    end
    # ordenamos el array por current_time, de menor a mayor
    arreglo.sort{|a,b| a[1] <=> b[1]}
  end

  # Determinamos si una inspección cumple con las condiciones
  def self.condition_accomplished?(arreglo, current_time, time_limit, condition_name)
    (arreglo.reject{ |a| a[1] >= current_time }.map{|row| [row[4], row[1]]}.uniq.include? [condition_name, current_time - time_limit])  ||
    (condition_name == 'Nuevo'  && current_time == time_limit) ||
    (condition_name == 'No requerido')
  end

  # def self.inspection_was_accomplished?(system_id, unit_name)
  #   Un arreglo de las horas de las inspecciones junto con sus condiciones de un determinado sistema
    # [[2400.0, "No requerido"], ...]
    # TimeLimit.joins(action: :scheduled_inspection).
    #           where('scheduled_inspections.system_id' => system_id).
    #           joins(:unit).
    #           where('units.name' => unit_name).pluck(:time, :inspection_id).
    #           map{|row| [row[0], Inspection.find(row[1]).name]}
  # end

  # Eliminamos aquellos que no cumplen las condiciones
  def self.remove_invalids(end_time, system_id, unit_name)
    depurados = []
    arreglo = self.all_inspections(end_time, system_id, unit_name)
    arreglo.each do |elemento|
      if self.condition_accomplished?(depurados, elemento[1], elemento[2], elemento[3])
        depurados.push(elemento)
      end
    end
    depurados
  end

  # Removemos aquellos que coinciden con una inspección prioritaria
  # [...[#<TimeLimit id: 40 ...>, 800, 400.0, "Intermediate Inspection", "Periodical Inspection"]...]
  # [...[#<TimeLimit id: 1 ...">, 100, 50.0, "No requerido", "Supplementary Check 50 Fh"]...]
  def self.keep_top_priority(init_time, end_time, system_id, unit_name)
    valid_items = []
    availables = self.remove_invalids(end_time, system_id, unit_name)
    availables.each do |element|
      # si no tiene inspecciones prioritarias
      if element[0].action.scheduled_inspection.inspections.empty?
        valid_items.push(element)
      else
        valid_items.push(element) unless self.por_lo_menos_uno(element[0].action.scheduled_inspection.inspections, system_id, element[1], unit_name) && self.prioritaria_presente?(availables, element)
      end
    end
    var = valid_items.reject { |a| a[1] < init_time }
    var.uniq
  end

  # Alguna inspección prioritaria debería ejecutarse?
  # [#<TimeLimit id: 1, action_id: 1 ...">, 150, 50.0, "No requerido", "Supplementary Check 50 Fh"],
  def self.priority?(inspection_name, system_id, current_time, unit_name)
    ScheduledInspection.where('name = ? AND system_id = ?', inspection_name, system_id).first.actions.each do |action|
      action.time_limits.each do |time_limit|
        if current_time % time_limit.time == 0 && time_limit.unit.name == unit_name
          return true
        end
      end
    end
    false
  end

  def self.por_lo_menos_uno(inspections, system_id, current_time, unit_name)
    var = false
    inspections.each do |inspection|
      var = var || self.priority?(inspection.name, system_id, current_time, unit_name)
    end
    var
  end

  def self.prioritaria_presente?(v_arreglo, v_elemento)
    arr = v_arreglo.reject { |a| a[1] != v_elemento[1] }.map{ |row| row[4]}
    v_elemento[0].action.scheduled_inspection.inspections.each do |inspection|
      if arr.include? inspection.name
        return true
      end
    end
    false
  end


  # Los nombres de inspecciones de un determinado sistema

  def self.inspection_names(system_id, unit_name)
    ScheduledInspection.where('system_id = ?',system_id).joins(actions: [{time_limits: :unit}]).where('units.name' => unit_name).distinct.pluck(:name)
  end





#   Descripción: Cada una de las inspecciones diferentes registradas
#   Tipo: Método de clase
#   Entradas: ninguna
#   Salida: Un arreglo de los nombres de las inspecciones ["Periodical Inspection", "Intermediate Inspection",...]
  def self.all_inspections_names
    pluck('DISTINCT name')
  end
#   Descripcion: Todas las inspecciones prioritarias de una determinada inspección programada
#   Tipo: Método de instancia
#   Entradas: ninguna
#   Salida: Un arreglo de los nombres de las inspecciones ["Supplementary Check 100 Fh", "Intermediate Inspection", ...]
#   def all_priority_inspections
#     inspections.pluck(:name)
#   end
#   Descripción: Tiempos limite de una determinada inspección
#   Tipo: Método de instancia
#   Entradas: El nombre de una unidad
#   Salida: Un arreglo de objetos de tipo TimeLimit ([#<TimeLimit...>,#<TimeLimit...>])
#   def time_limit(unit_name)
#     arreglo = []
#     actions.each do |action|
#       action.time_limits.each do |time_limit|
#         if time_limit.unit.name == unit_name
#           arreglo.push(time_limit )
#         end
#       end
#     end
#     arreglo
#   end
#   Descripción: Todos los tiempos limite de una determinada inspección antes de un tiempo dado, suponiendo que no existen inspecciones prioritarias
#   Tipo:        Método de instancia
#   Entradas:    Un tiempo y su unidad
#   Salida:      Arreglo de pares objetos TiempoLimite y hora([[#<TiempoLimite>, 50],[]])
#   def all_time_limits(time, unit_name)
#     arreglo = []
#     time_limit(unit_name).each do |time_limit|
#       (1..time).each do |t|
#         if t % time_limit.time == 0
#           arreglo.push([time_limit, t, time_limit.inspection.name])
#         end
#       end
#     end
#     arreglo
#   end

#   Descripción: Todos los tiempos limite de una determinada inspección antes de un tiempo dado, suponiendo que existen inspecciones prioritarias
#   Tipo:        Método de instancia
#   Entradas:    Un tiempo y la unidad del tiempo
#   Salida:      Arreglo de pares objetos TiempoLimite y hora([[#<TiempoLimite>, 50],[]])
# def time_limits(time, unit_name)
#   arreglo = all_time_limits(time, unit_name)
#   all_priority_inspections.each do |name_inspection|
#     priority_inspection_array = ScheduledInspection.where('system_id = ? AND name = ?', system_id, name_inspection).first.all_time_limits(time, unit_name)
#     arreglo = arreglo.reject{|e| priority_inspection_array.map{|row| row[1]}.include? e.last}
#   end
#   arreglo
# end



# Nombres de las inspecciones previamente realizadas
  # def self.previous_inspections(arreglo, current_time)
  #  arreglo.reject{ |a| a[1] >= current_time }.map{|row| row[4]}.uniq
  # end
  # Para saber si cumple la condición
  # row[1] -> current_time
  # row[4] -> inspection_name

  # def self.cumple_la_condicion?(time)
  #
  #   arreglo = self.where('time = ?', array[2]).first.action.scheduled_inspection.name == array[3]
  #   arreglo = arreglo.reject { |a| a.last < time }
  # end

  # def self.condiciones_en(time)
  #   arreglo = []
  #   TimeLimit.where('time = ?', time).pluck('DISTINCT inspection_id').each do |id|
  #     arreglo.push(Inspection.find(id).name)
  #   end
  #   arreglo
  # end

  # def self.inspecciones_en(time)
  #   arreglo = []
  #   TimeLimit.all.each  do |time_limit|
  #     arreglo.push(time_limit.action.scheduled_inspection.name) if  time % time_limit.time == 0
  #   end
  #   arreglo.uniq
  # end
end






