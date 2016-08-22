class AddProductQuantityIdToOutgoingDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :outgoing_details, :product_quantity_id, :integer
  end
end
