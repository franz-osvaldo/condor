class AddPartNumberToProductQuantities < ActiveRecord::Migration[5.0]
  def change
    add_column :product_quantities, :part_number, :string
  end
end
