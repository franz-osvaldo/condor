class AddAlertBeforeToTbos < ActiveRecord::Migration[5.0]
  def change
    add_column :tbos, :alert_before, :float
  end
end
