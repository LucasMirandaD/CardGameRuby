class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players, id: :uuid do |t|
      t.string :name
      t.string :password
      t.string :nickname, unique: true
      t.string :email, unique: true
      t.string :token, optional: true
      t.uuid :image_id
      t.timestamps
    end

    add_foreign_key :players, :images, column: :image_id, on_delete: :nullify
  end
end
