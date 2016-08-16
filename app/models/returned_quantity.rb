class ReturnedQuantity < ApplicationRecord
  belongs_to :tool_quantity
  belongs_to :returned_tool
  after_create :update_quantity_available

  private
  def update_quantity_available
    record = ToolQuantity.find(self.tool_quantity_id)
    record.update(:quantity_available => 1)
  end
end
