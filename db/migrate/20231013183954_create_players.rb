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

    create_table :images, id: :uuid do |t|
      t.references :player, foreign_key: true, type: :uuid
      t.string :name
      t.timestamps
    end

    # add_reference :active_storage_attachments, :file, foreign_key: true, type: :uuid

    add_foreign_key :players, :images, column: :image_id, type: :uuid
  end
end
