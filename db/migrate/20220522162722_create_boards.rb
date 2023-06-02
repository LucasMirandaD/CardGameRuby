class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|

      t.timestamps
      t.belongs_to :player_1, class_name: "Player"
      t.belongs_to :player_2, class_name: "Player", optional: true
      t.string :board_name, unique: true
      t.integer :turn, default: 0
      t.integer :winner
    end
  end
end
