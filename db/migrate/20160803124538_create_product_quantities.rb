class CreateProductQuantities < ActiveRecord::Migration[5.0]
  def change
    create_table :product_quantities do |t|
      t.references :product, foreign_key: true
      t.string :description
      t.float :quantity
      t.date :expiration_date

      t.timestamps
    end
  end
end
