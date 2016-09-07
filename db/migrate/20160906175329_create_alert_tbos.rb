class CreateAlertTbos < ActiveRecord::Migration[5.0]
  def change
    create_table :alert_tbos do |t|
      t.references :fleet, foreign_key: true
      t.references :tbo, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
