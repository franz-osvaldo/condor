class CreateParts < ActiveRecord::Migration[5.0]
  def change
    create_table :parts do |t|
      t.references :component, foreign_key: true
      t.string :description
      t.string :part_number

      t.timestamps
    end
  end
end
