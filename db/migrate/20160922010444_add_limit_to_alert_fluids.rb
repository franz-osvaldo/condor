class AddLimitToAlertFluids < ActiveRecord::Migration[5.0]
  def change
    add_column :alert_fluids, :limit, :integer
  end
end
