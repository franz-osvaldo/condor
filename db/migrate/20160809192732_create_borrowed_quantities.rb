class CreateBorrowedQuantities < ActiveRecord::Migration[5.0]
  def change
    create_table :borrowed_quantities do |t|
      t.references :borrowed_tool, foreign_key: true
      t.references :tool_quantity, foreign_key: true
      t.integer :quantity
      t.date :expiration_date, default: '3000-01-01'

      t.timestamps
    end
  end
end
