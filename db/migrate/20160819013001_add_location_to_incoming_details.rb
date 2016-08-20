class AddLocationToIncomingDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :incoming_details, :aisle, :string
    add_column :incoming_details, :section, :string
    add_column :incoming_details, :level, :string
    add_column :incoming_details, :position, :string
    add_column :incoming_details, :serial_number, :string
  end
end
