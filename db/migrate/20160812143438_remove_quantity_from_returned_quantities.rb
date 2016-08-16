class RemoveQuantityFromReturnedQuantities < ActiveRecord::Migration[5.0]
  def change
    remove_column :returned_quantities, :quantity, :integer
  end
end
