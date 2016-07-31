class CreateIncomingMovements < ActiveRecord::Migration[5.0]
  def change
    create_table :incoming_movements do |t|
      t.references :incoming_movement_type, foreign_key: true
      t.references :supplier, foreign_key: true
      t.string :folio

      t.timestamps
    end
  end
end
