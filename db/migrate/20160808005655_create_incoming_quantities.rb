class CreateIncomingQuantities < ActiveRecord::Migration[5.0]
  def change
    create_table :incoming_quantities do |t|
      t.references :incoming_tool, foreign_key: true
      t.references :tool, foreign_key: true
      t.integer :quantity, default: 1
      t.string :serial_number

      t.timestamps
    end
  end
end
