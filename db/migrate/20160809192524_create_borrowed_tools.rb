class CreateBorrowedTools < ActiveRecord::Migration[5.0]
  def change
    create_table :borrowed_tools do |t|
      t.references :user, foreign_key: true
      t.string :folio
      t.string :state

      t.timestamps
    end
  end
end
