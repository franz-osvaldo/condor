class CreateActions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.references :scheduled_inspection, foreign_key: true
      t.text :step

      t.timestamps
    end
  end
end
