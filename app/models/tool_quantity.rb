class ToolQuantity < ApplicationRecord
  belongs_to :tool
  has_many :borrowed_quantities
  has_many :borrowed_tools, through: :borrowed_quantities
  has_many :returned_quantities
  has_many :returned_tools, through: :returned_quantities


  def self.add_quantity(v_tool_id, v_serial_number, v_aisle, v_section, v_level, v_position)
    self.create(:tool_id => v_tool_id,
                :quantity_available => 1,
                :serial_number => v_serial_number,
                :aisle => v_aisle,
                :section => v_section,
                :level => v_level,
                :position => v_position)
  end

  def self.subtract_quantity(v_tool_quantity_id)
    self.find(v_tool_quantity_id).update(:quantity_available => 0, :asset => false, :user_id => 0)
  end

  def expiration
    self.borrowed_quantities.last.expiration_date
  end

  # El nombre del custodio
  def user_name
    User.find(self.user_id).name
  end

  # El numero de herramientas que sobrepasaron la fecha de devolución  
  def self.out_of_date_quantity
    cont = 0
    self.where('quantity_available = ? AND asset = ?' , 0, true).each do |tool_quantity|
      if tool_quantity.expiration < Date.today
        cont += 1
      end
    end
    return cont
  end
  # El numero actual de custodios 
  def self.number_of_custodians
    self.where('quantity_available = ? AND asset = ? ', 0, true).select(:user_id).group(:user_id).length
  end
  #  La ubicación
  def location
    if self.aisle.nil? || self.section.nil? || self.level.nil? || self.position.nil?
      'ND'
    else
      self.aisle+'-'+self.section+'-'+self.level+'-'+self.position
    end
  end
end
