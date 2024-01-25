class AddIndexPlayerToBoards < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :boards, :players, column: :player1_id, null: false
    add_foreign_key :boards, :players, column: :player2_id
  end
end
