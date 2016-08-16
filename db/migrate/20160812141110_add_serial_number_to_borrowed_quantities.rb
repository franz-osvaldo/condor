class AddSerialNumberToBorrowedQuantities < ActiveRecord::Migration[5.0]
  def change
    add_column :borrowed_quantities, :serial_number, :string
  end
end
