class CreateReturnedQuantities < ActiveRecord::Migration[5.0]
  def change
    create_table :returned_quantities do |t|
      t.references :tool_quantity, foreign_key: true
      t.references :returned_tool, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
