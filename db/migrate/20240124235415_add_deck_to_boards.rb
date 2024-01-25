class AddDeckToBoards < ActiveRecord::Migration[7.0]
  def change
    add_reference :boards, :deck, null: false, foreign_key: true, default: [], type: :uuid
  end
end
