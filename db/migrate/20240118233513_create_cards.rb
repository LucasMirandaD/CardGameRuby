class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards, id: :uuid do |t|
      t.references :player, type: :uuid, foreign_key: true
      t.string :card

      t.timestamps
    end
  end
end