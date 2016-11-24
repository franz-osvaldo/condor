class AddStateToBugReports < ActiveRecord::Migration[5.0]
  def change
    add_column :bug_reports, :state, :boolean, default: false
  end
end
