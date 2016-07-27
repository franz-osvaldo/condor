class CreateInspections < ActiveRecord::Migration[5.0]
  def change
    create_table :inspections do |t|
      t.string :mame

      t.timestamps
    end
  end
end
