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

ActiveRecord::Schema.define(version: 20171207211241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_socials", force: :cascade do |t|
    t.string "url"
    t.string "name"
    t.bigint "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_artist_socials_on_artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "artist_tm_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists_genres", id: false, force: :cascade do |t|
    t.bigint "artist_id"
    t.bigint "genre_id"
    t.index ["artist_id"], name: "index_artists_genres_on_artist_id"
    t.index ["genre_id"], name: "index_artists_genres_on_genre_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "event_tm_id"
    t.string "name", null: false
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "artist_id"
    t.bigint "venue_id"
    t.integer "user_id"
    t.string "image"
    t.index ["artist_id"], name: "index_events_on_artist_id"
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "genre_tm_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "genre_id", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ratio"
    t.integer "event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatars"
    t.index ["email"], name: "index_users_on_email"
  end

  create_table "venue_images", force: :cascade do |t|
    t.string "ratio"
    t.string "url"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_venue_images_on_venue_id"
  end

  create_table "venues", force: :cascade do |t|
    t.string "venue_tm_id"
    t.string "name", null: false
    t.string "address_1", null: false
    t.string "address_2"
    t.string "city", null: false
    t.string "province", null: false
    t.string "postal_code", null: false
    t.string "country"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "full_address"
  end

end
