class RenameMameToNameInInspections < ActiveRecord::Migration[5.0]
  def change
    rename_column :inspections, :mame, :name
  end
end
