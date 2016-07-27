class CreateOverTheTimeLimits < ActiveRecord::Migration[5.0]
  def change
    create_table :over_the_time_limits do |t|
      t.references :time_limit, foreign_key: true
      t.references :unit, foreign_key: true
      t.float :time

      t.timestamps
    end
  end
end
