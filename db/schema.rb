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

ActiveRecord::Schema.define(version: 20141206103256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: true do |t|
    t.integer  "player_id",                                      null: false
    t.date     "game_date"
    t.string   "opponent"
    t.string   "score"
    t.time     "minutes"
    t.integer  "field_goals_made"
    t.integer  "field_goals_attempted"
    t.decimal  "field_goal_percentage",  precision: 4, scale: 1
    t.integer  "three_points_made"
    t.integer  "three_points_attempted"
    t.decimal  "three_point_percentage", precision: 4, scale: 1
    t.integer  "free_throws_made"
    t.integer  "free_throws_attempted"
    t.decimal  "free_throw_percentage",  precision: 4, scale: 1
    t.integer  "offensive_rebounds"
    t.integer  "defensive_rebounds"
    t.integer  "rebounds"
    t.integer  "assists"
    t.integer  "turnovers"
    t.integer  "steals"
    t.integer  "blocks"
    t.integer  "personal_fouls"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["player_id"], name: "index_games_on_player_id", using: :btree

  create_table "player_positions", force: true do |t|
    t.integer  "player_id",   null: false
    t.integer  "position_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_positions", ["player_id", "position_id"], name: "index_player_positions_on_player_id_and_position_id", unique: true, using: :btree

  create_table "players", id: false, force: true do |t|
    t.integer  "id",                        null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "active",     default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["first_name", "last_name"], name: "index_players_on_first_name_and_last_name", unique: true, using: :btree
  add_index "players", ["id"], name: "index_players_on_id", unique: true, using: :btree
  add_index "players", ["last_name"], name: "index_players_on_last_name", using: :btree

  create_table "positions", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positions", ["name"], name: "index_positions_on_name", unique: true, using: :btree

end
