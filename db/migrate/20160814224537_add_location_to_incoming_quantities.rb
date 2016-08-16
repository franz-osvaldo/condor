class AddLocationToIncomingQuantities < ActiveRecord::Migration[5.0]
  def change
    add_column :incoming_quantities, :aisle, :string
    add_column :incoming_quantities, :section, :string
    add_column :incoming_quantities, :level, :string
    add_column :incoming_quantities, :position, :string
  end
end
