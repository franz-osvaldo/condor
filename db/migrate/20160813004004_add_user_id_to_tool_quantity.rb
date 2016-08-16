class AddUserIdToToolQuantity < ActiveRecord::Migration[5.0]
  def change
    add_column :tool_quantities, :user_id, :integer, default: 0
  end
end
