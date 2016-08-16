class AddToolQuantityIdToOutgoingQuantities < ActiveRecord::Migration[5.0]
  def change
    add_column :outgoing_quantities, :tool_quantity_id, :integer
  end
end
