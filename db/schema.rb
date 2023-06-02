# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_22_162722) do
  create_table "boards", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "player_1_id"
    t.bigint "player_2_id"
    t.string "board_name"
    t.integer "turn", default: 0
    t.integer "winner"
    t.index ["player_1_id"], name: "index_boards_on_player_1_id"
    t.index ["player_2_id"], name: "index_boards_on_player_2_id"
  end

  create_table "players", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "password"
    t.string "nickname"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
