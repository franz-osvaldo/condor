class CreateLifeTimeLimits < ActiveRecord::Migration[5.0]
  def change
    create_table :life_time_limits do |t|
      t.references :part, foreign_key: true
      t.references :unit, foreign_key: true
      t.float :life_limit
      t.float :alert_before

      t.timestamps
    end
  end
end
