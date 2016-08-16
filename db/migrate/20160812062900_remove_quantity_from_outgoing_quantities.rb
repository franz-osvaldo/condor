class RemoveQuantityFromOutgoingQuantities < ActiveRecord::Migration[5.0]
  def change
    remove_column :outgoing_quantities, :quantity, :integer
  end
end
