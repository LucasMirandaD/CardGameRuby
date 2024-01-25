class CreateDecks < ActiveRecord::Migration[7.0]
  def change
    create_table :decks, id: :uuid do |t|
      t.string :content, array: true, default: [], null: false
      t.references :board, null: false, type: :uuid, foreign_key: true
      t.references :player, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
