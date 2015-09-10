# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150910180002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "foes", force: :cascade do |t|
    t.integer  "foe_requester_id"
    t.integer  "foe_responder_id"
    t.integer  "status"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "white_player_id"
    t.integer  "black_player_id"
    t.integer  "turn"
    t.integer  "turn_status"
    t.integer  "chip0_position"
    t.integer  "chip1_position"
    t.integer  "chip2_position"
    t.integer  "chip3_position"
    t.integer  "chip4_position"
    t.integer  "chip5_position"
    t.integer  "chip6_position"
    t.integer  "chip7_position"
    t.integer  "chip8_position"
    t.integer  "chip9_position"
    t.integer  "chip10_position"
    t.integer  "chip11_position"
    t.integer  "chip12_position"
    t.integer  "chip13_position"
    t.integer  "chip14_position"
    t.integer  "chip15_position"
    t.integer  "chip16_position"
    t.integer  "chip17_position"
    t.integer  "chip18_position"
    t.integer  "chip19_position"
    t.integer  "chip20_position"
    t.integer  "chip21_position"
    t.integer  "chip22_position"
    t.integer  "chip23_position"
    t.integer  "chip24_position"
    t.integer  "chip25_position"
    t.integer  "chip26_position"
    t.integer  "chip27_position"
    t.integer  "chip28_position"
    t.integer  "chip29_position"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "username"
    t.integer  "logged_in"
    t.time     "last_activity"
    t.integer  "num_games"
    t.integer  "num_wins"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
