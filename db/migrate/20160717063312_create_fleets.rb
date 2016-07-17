class CreateFleets < ActiveRecord::Migration[5.0]
  def change
    create_table :fleets do |t|
      t.references :aircraft, foreign_key: true
      t.string :name
      t.string :aircraft_registration

      t.timestamps
    end
  end
end
