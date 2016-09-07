class CreateFluids < ActiveRecord::Migration[5.0]
  def change
    create_table :fluids do |t|
      t.references :part, foreign_key: true
      t.references :condition, foreign_key: true
      t.references :unit, foreign_key: true
      t.float :time_limit
      t.float :alert_before
      t.float :over_the_time_limit

      t.timestamps
    end
  end
end
