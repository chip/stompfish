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

ActiveRecord::Schema.define(version: 20140322171734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: true do |t|
    t.text     "title",      default: "", null: false
    t.string   "image"
    t.integer  "artist_id",  default: 0,  null: false
    t.string   "genre"
    t.string   "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["artist_id"], name: "index_albums_on_artist_id", using: :btree
  add_index "albums", ["id"], name: "index_albums_on_id", using: :btree

  create_table "artists", force: true do |t|
    t.text     "name",       default: "", null: false
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["id"], name: "index_artists_on_id", using: :btree

  create_table "import_logs", force: true do |t|
    t.text     "stacktrace"
    t.text     "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playlists", force: true do |t|
    t.string   "title",      default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playlists", ["id"], name: "index_playlists_on_id", using: :btree

  create_table "song_files", force: true do |t|
    t.integer  "filesize"
    t.text     "filename",      default: "", null: false
    t.integer  "bit_rate"
    t.string   "format"
    t.float    "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fileable_id",   default: 0,  null: false
    t.string   "fileable_type", default: "", null: false
    t.datetime "mtime"
  end

  add_index "song_files", ["fileable_id", "fileable_type"], name: "index_song_files_on_fileable_id_and_fileable_type", using: :btree
  add_index "song_files", ["id"], name: "index_song_files_on_id", using: :btree

  create_table "songs", force: true do |t|
    t.text     "title",      default: "", null: false
    t.integer  "artist_id",  default: 0,  null: false
    t.integer  "album_id",   default: 0,  null: false
    t.integer  "track"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songs", ["album_id"], name: "index_songs_on_album_id", using: :btree
  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id", using: :btree
  add_index "songs", ["id"], name: "index_songs_on_id", using: :btree

end
