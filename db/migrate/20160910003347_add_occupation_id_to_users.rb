class AddOccupationIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :occupation, foreign_key: true
  end
end