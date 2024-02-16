class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards, id: :uuid do |t|
      t.uuid :player1_id, null: false
      t.uuid :player2_id
      t.string :board_name
      t.integer :winner
      t.string :last_card

      t.timestamps
    end
  end
end
