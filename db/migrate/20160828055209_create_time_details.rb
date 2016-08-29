class CreateTimeDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :time_details do |t|
      t.references :part, foreign_key: true
      t.references :fleet, foreign_key: true
      t.float :fhsn
      t.integer :dsn
      t.float :fhso
      t.integer :dso
      t.string :overhaul_state
      t.datetime :overhaul_date

      t.timestamps
    end
  end
end
