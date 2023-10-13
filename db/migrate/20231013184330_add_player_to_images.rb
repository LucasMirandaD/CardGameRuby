class AddPlayerToImages < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :player_id, :uuid, null: false
    add_foreign_key :images, :players, column: :player_id, on_delete: :cascade
  end
end
