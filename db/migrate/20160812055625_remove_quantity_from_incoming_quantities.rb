class RemoveQuantityFromIncomingQuantities < ActiveRecord::Migration[5.0]
  def change
    remove_column :incoming_quantities, :quantity, :integer
  end
end
