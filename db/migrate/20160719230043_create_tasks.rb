class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.references :system, foreign_key: true
      t.string :name
      t.string :task_number

      t.timestamps
    end
  end
end
