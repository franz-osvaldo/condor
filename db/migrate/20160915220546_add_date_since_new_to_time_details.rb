class AddDateSinceNewToTimeDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :time_details, :date_since_new, :datetime
  end
end
