class CreateDecks < ActiveRecord::Migration[7.0]
  def change
    create_table :decks, id: :uuid do |t|
      t.string :content, array: true, default: [], null: false
      t.belongs_to :board, type: :uuid, foreign_key: true
      t.belongs_to :player, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
