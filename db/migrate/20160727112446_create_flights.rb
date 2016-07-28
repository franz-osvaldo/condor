class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.references :fleet, foreign_key: true
      t.time :takeoff_time
      t.time :landing_time
      t.float :flight_time
      t.date :departure_date
      t.time :departure_time
      t.time :arrival_time
      t.float :block_time

      t.timestamps
    end
  end
end
