class CreatePriorities < ActiveRecord::Migration[5.0]
  def change
    create_table :priorities do |t|
      t.references :scheduled_inspection, foreign_key: true
      t.references :inspection, foreign_key: true

      t.timestamps
    end
  end
end
