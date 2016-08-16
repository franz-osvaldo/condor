class AddLocationToToolQuantities < ActiveRecord::Migration[5.0]
  def change
    add_column :tool_quantities, :aisle, :string
    add_column :tool_quantities, :section, :string
    add_column :tool_quantities, :level, :string
    add_column :tool_quantities, :position, :string
  end
end
