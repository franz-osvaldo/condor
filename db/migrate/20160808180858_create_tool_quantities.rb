class CreateToolQuantities < ActiveRecord::Migration[5.0]
  def change
    create_table :tool_quantities do |t|
      t.references :tool, foreign_key: true
      t.integer :total_quantity
      t.integer :quantity_available
      t.string  :serial_number
      t.timestamps
    end
  end
end
