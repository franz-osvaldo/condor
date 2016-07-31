class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :procurement_lead_time
      t.string :part_number
      t.string :description
      t.text :specification
      t.integer :maximum
      t.integer :minimum
      t.integer :optimum
      t.boolean :obsolete, default: false

      t.timestamps
    end
  end
end
