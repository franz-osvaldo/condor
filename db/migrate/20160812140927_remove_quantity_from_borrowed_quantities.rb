class RemoveQuantityFromBorrowedQuantities < ActiveRecord::Migration[5.0]
  def change
    remove_column :borrowed_quantities, :quantity, :integer
  end
end
