class CreateTimeLimits < ActiveRecord::Migration[5.0]
  def change
    create_table :time_limits do |t|
      t.references :action, foreign_key: true
      t.references :unit, foreign_key: true
      t.references :inspection, foreign_key: true
      t.float :time

      t.timestamps
    end
  end
end
