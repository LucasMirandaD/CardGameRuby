class AddIndexDeckToBoards < ActiveRecord::Migration[7.0]
  def change
    add_reference :boards, :deck, column: :deck_id, type: :uuid, foreign_key: true
  end
end
