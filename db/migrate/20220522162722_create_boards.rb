class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards, id: :uuid do |t|
      t.uuid :player1_id, null: false
      t.uuid :player2_id
      t.string :board_name
      t.string :winner
      t.string :last_card
      t.boolean :was_dealt, default: false
      t.integer :player1_score, default: 0
      t.integer :player2_score, default: 0

      t.timestamps
    end
  end
end
