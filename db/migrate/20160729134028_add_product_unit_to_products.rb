class AddProductUnitToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :product_unit, foreign_key: true
  end
end
