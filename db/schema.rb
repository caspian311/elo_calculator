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

ActiveRecord::Schema.define(version: 20160530181405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "clubs", ["slug"], name: "index_clubs_on_slug", using: :btree

  create_table "entries", force: :cascade do |t|
    t.integer  "tournament_id"
    t.integer  "player_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "entries", ["player_id"], name: "index_entries_on_player_id", using: :btree
  add_index "entries", ["tournament_id"], name: "index_entries_on_tournament_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.integer  "winner_rating"
    t.integer  "loser_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.integer  "matchup_id"
  end

  add_index "games", ["loser_id"], name: "index_games_on_loser_id", using: :btree
  add_index "games", ["matchup_id"], name: "index_games_on_matchup_id", using: :btree
  add_index "games", ["winner_id"], name: "index_games_on_winner_id", using: :btree

  create_table "matchups", force: :cascade do |t|
    t.integer  "primary_id"
    t.integer  "secondary_id"
    t.integer  "winner_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "matchups", ["tournament_id"], name: "index_matchups_on_tournament_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["club_id"], name: "index_memberships_on_club_id", using: :btree
  add_index "memberships", ["player_id"], name: "index_memberships_on_player_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.integer  "rating",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["name"], name: "index_players_on_name", using: :btree
  add_index "players", ["rating"], name: "index_players_on_rating", using: :btree

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "memberships", "clubs"
  add_foreign_key "memberships", "players"
end
