class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :lastname
      t.string :password
      t.string :nickname, unique: true
      t.string :token, optional: true
      t.timestamps
    end
  end
end
