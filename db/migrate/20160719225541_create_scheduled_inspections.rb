class CreateScheduledInspections < ActiveRecord::Migration[5.0]
  def change
    create_table :scheduled_inspections do |t|
      t.references :system, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
