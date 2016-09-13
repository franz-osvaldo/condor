class AddTboIdToFluids < ActiveRecord::Migration[5.0]
  def change
    add_reference :fluids, :tbo, foreign_key: true
  end
end
