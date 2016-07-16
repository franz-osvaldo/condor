class CreateSystems < ActiveRecord::Migration[5.0]
  def change
    create_table :systems do |t|
      t.references :aircraft, foreign_key: true
      t.string :title
      t.integer :chapter_number

      t.timestamps
    end
  end
end
