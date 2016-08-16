class AddAssetToToolQuantities < ActiveRecord::Migration[5.0]
  def change
    add_column :tool_quantities, :asset, :boolean, default: true
  end
end
