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

ActiveRecord::Schema.define(version: 20171015140839) do

  create_table "bands", force: :cascade do |t|
    t.date     "joining"
    t.date     "leaving"
    t.integer  "individual_id"
    t.integer  "group_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["group_id"], name: "index_bands_on_group_id"
    t.index ["individual_id"], name: "index_bands_on_individual_id"
  end

  create_table "concerts", force: :cascade do |t|
    t.date     "cdate"
    t.integer  "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_concerts_on_venue_id"
  end

  create_table "concerts_performers", id: false, force: :cascade do |t|
    t.integer "concert_id",   null: false
    t.integer "performer_id", null: false
  end

  create_table "concerts_users", id: false, force: :cascade do |t|
    t.integer "concert_id", null: false
    t.integer "user_id",    null: false
  end

  create_table "performances", force: :cascade do |t|
    t.integer  "position"
    t.integer  "concert_id"
    t.integer  "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concert_id"], name: "index_performances_on_concert_id"
    t.index ["song_id"], name: "index_performances_on_song_id"
  end

  create_table "performances_performers", id: false, force: :cascade do |t|
    t.integer "performance_id", null: false
    t.integer "performer_id",   null: false
  end

  create_table "performers", force: :cascade do |t|
    t.string   "type"
    t.string   "pname"
    t.text     "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title"
    t.string   "genre"
    t.string   "ytid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "isadmin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string   "vname"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
