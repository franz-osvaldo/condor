class CreateAircrafts < ActiveRecord::Migration[5.0]
  def change
    create_table :aircrafts do |t|
      t.string :manufacturer
      t.string :trade_name

      t.timestamps
    end
  end
end
