class CreateAlertLifeLimits < ActiveRecord::Migration[5.0]
  def change
    create_table :alert_life_limits do |t|
      t.references :life_time_limit, foreign_key: true
      t.references :fleet, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
