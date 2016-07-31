class CreateIncomingDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :incoming_details do |t|
      t.references :incoming_movement, foreign_key: true
      t.references :product, foreign_key: true
      t.float :quantity
      t.date :expiration_date

      t.timestamps
    end
  end
end
