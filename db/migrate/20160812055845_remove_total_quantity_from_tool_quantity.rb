class RemoveTotalQuantityFromToolQuantity < ActiveRecord::Migration[5.0]
  def change
    remove_column :tool_quantities, :total_quantity, :integer
  end
end
