class RemoveExpirationDateFromOutgoingDetails < ActiveRecord::Migration[5.0]
  def change
    remove_column :outgoing_details, :expiration_date, :date
  end
end
