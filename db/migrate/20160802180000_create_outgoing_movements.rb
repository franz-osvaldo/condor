class CreateOutgoingMovements < ActiveRecord::Migration[5.0]
  def change
    create_table :outgoing_movements do |t|
      t.references :outgoing_movement_type, foreign_key: true
      t.references :receiver, foreign_key: true
      t.string :folio

      t.timestamps
    end
  end
end
