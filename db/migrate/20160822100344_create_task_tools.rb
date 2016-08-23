class CreateTaskTools < ActiveRecord::Migration[5.0]
  def change
    create_table :task_tools do |t|
      t.references :tool, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
