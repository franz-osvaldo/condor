class AddReceiverToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :receiver, :boolean, default: false
  end
end
