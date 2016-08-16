class BorrowedQuantity < ApplicationRecord
  belongs_to :borrowed_tool
  belongs_to :tool_quantity
  before_save :set_expiration_date
  after_create :update_quantity_available

  private
  def set_expiration_date
    if self.expiration_date.nil?
      self.expiration_date = '3000-01-01'
    end
  end
  def update_quantity_available
    record = ToolQuantity.find(self.tool_quantity_id)
    record.update(:quantity_available => 0, :user_id => self.borrowed_tool.user_id)
  end
end
