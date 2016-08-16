class CreateOutgoingToolTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :outgoing_tool_types do |t|
      t.string :movement_type

      t.timestamps
    end
  end
end
