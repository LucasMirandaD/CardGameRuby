class AddDeckToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_reference :players, :deck, column: :deck_id, type: :uuid, foreign_key: true
  end
end
