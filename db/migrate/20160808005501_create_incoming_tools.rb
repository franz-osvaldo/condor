class CreateIncomingTools < ActiveRecord::Migration[5.0]
  def change
    create_table :incoming_tools do |t|
      t.references :incoming_tool_type, foreign_key: true
      t.string :folio

      t.timestamps
    end
  end
end
