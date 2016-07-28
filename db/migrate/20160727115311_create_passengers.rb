class CreatePassengers < ActiveRecord::Migration[5.0]
  def change
    create_table :passengers do |t|
      t.references :flight, foreign_key: true
      t.string :name
      t.string :identification_number

      t.timestamps
    end
  end
end
