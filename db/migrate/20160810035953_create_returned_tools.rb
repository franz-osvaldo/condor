class CreateReturnedTools < ActiveRecord::Migration[5.0]
  def change
    create_table :returned_tools do |t|
      t.references :user, foreign_key: true
      t.string :folio

      t.timestamps
    end
  end
end
