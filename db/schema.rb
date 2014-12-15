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

ActiveRecord::Schema.define(version: 20141215041341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: true do |t|
    t.integer  "player_id",                                      null: false
    t.date     "game_date"
    t.string   "opponent"
    t.string   "score"
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
    t.decimal  "fanduel",                precision: 4, scale: 1
    t.decimal  "minutes",                precision: 5, scale: 2
  end

  add_index "games", ["player_id"], name: "index_games_on_player_id", using: :btree

  create_table "players", id: false, force: true do |t|
    t.integer  "id",                        null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "active",     default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "players", ["first_name", "last_name"], name: "index_players_on_first_name_and_last_name", unique: true, using: :btree
  add_index "players", ["id"], name: "index_players_on_id", unique: true, using: :btree
  add_index "players", ["last_name"], name: "index_players_on_last_name", using: :btree
  add_index "players", ["name"], name: "index_players_on_name", unique: true, using: :btree

  create_table "salaries", force: true do |t|
    t.integer  "user_id",                                                null: false
    t.integer  "player_id",                                              null: false
    t.string   "position",                                               null: false
    t.integer  "salary",                                                 null: false
    t.decimal  "cost_per_point", precision: 8, scale: 2
    t.boolean  "late",                                   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "salaries", ["user_id", "player_id", "late"], name: "index_salaries_on_user_id_and_player_id_and_late", unique: true, using: :btree

  create_table "statistics", force: true do |t|
    t.integer  "player_id"
    t.decimal  "mean",                precision: 4, scale: 2
    t.decimal  "std_dev",             precision: 4, scale: 2
    t.decimal  "cv",                  precision: 4, scale: 3
    t.decimal  "confidence_interval", precision: 4, scale: 2
    t.integer  "games_played"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "max_fanduel",         precision: 4, scale: 1
  end

  add_index "statistics", ["player_id"], name: "index_statistics_on_player_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "admin",                  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
