class CreateAlertFluids < ActiveRecord::Migration[5.0]
  def change
    create_table :alert_fluids do |t|
      t.references :fleet, foreign_key: true
      t.references :fluid, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
