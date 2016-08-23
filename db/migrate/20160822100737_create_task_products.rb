class CreateTaskProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :task_products do |t|
      t.references :task, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
