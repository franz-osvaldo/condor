class CreateOutgoingTools < ActiveRecord::Migration[5.0]
  def change
    create_table :outgoing_tools do |t|
      t.references :outgoing_tool_type, foreign_key: true
      t.string :folio

      t.timestamps
    end
  end
end
