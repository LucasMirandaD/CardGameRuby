class AddDeckToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_reference :players, :deck, null: false, foreign_key: true, default: [], type: :uuid
  end
end
