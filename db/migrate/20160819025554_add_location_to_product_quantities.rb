class AddLocationToProductQuantities < ActiveRecord::Migration[5.0]
  def change
    add_column :product_quantities, :aisle, :string
    add_column :product_quantities, :section, :string
    add_column :product_quantities, :level, :string
    add_column :product_quantities, :position, :string
    add_column :product_quantities, :serial_number, :string
  end
end
