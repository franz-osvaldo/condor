class IncomingQuantity < ApplicationRecord
  belongs_to :incoming_tool
  belongs_to :tool

  validates_with ToolLocation
  validates_with ToolSerialNumber
  validates :serial_number, :aisle, :section, :level, :position,  presence: true

  after_create :set_tool_quantity

  def set_tool_quantity
    ToolQuantity.add_quantity(self.tool_id, self.serial_number, self.aisle, self.section, self.level, self.position)
  end
  def location
    if self.aisle.nil? || self.section.nil? || self.level.nil? || self.position.nil?
      'ND'
    else
      self.aisle+'-'+self.section+'-'+self.level+'-'+self.position
    end
  end
end
