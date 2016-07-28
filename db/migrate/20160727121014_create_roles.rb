class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.references :flight_crew, foreign_key: true
      t.references :flight, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
