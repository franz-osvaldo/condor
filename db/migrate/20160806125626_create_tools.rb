class CreateTools < ActiveRecord::Migration[5.0]
  def change
    create_table :tools do |t|
      t.string :part_number
      t.string :description
      t.text :specification

      t.timestamps
    end
  end
end
