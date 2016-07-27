class CreateProcedures < ActiveRecord::Migration[5.0]
  def change
    create_table :procedures do |t|
      t.references :task, foreign_key: true
      t.references :action, foreign_key: true
      t.string :procedure

      t.timestamps
    end
  end
end
