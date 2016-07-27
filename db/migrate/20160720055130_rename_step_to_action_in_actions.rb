class RenameStepToActionInActions < ActiveRecord::Migration[5.0]
  def change
    rename_column :actions, :step, :action
  end
end
