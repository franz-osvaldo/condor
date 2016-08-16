class AddSerialNumberToReturnedQuantities < ActiveRecord::Migration[5.0]
  def change
    add_column :returned_quantities, :serial_number, :string
  end
end
