class OutgoingQuantity < ApplicationRecord
  belongs_to :outgoing_tool
  belongs_to :tool
  after_create :set_tool_quantity

  def set_tool_quantity
    ToolQuantity.subtract_quantity(self.tool_quantity_id)
  end

end


