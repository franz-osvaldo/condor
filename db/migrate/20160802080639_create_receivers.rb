class CreateReceivers < ActiveRecord::Migration[5.0]
  def change
    create_table :receivers do |t|
      t.string :receiver

      t.timestamps
    end
  end
end
