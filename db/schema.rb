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

ActiveRecord::Schema.define(version: 20150111063156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: true do |t|
    t.integer  "trip_id"
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "proposed_date"
    t.string   "currency_code", default: "aud"
  end

  add_index "areas", ["trip_id"], name: "index_areas_on_trip_id", using: :btree

  create_table "attractions", force: true do |t|
    t.integer  "area_id"
    t.string   "name"
    t.text     "description"
    t.integer  "cost"
    t.string   "image"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency_code", default: "aud"
  end

  add_index "attractions", ["area_id"], name: "index_attractions_on_area_id", using: :btree

  create_table "trip_rights", force: true do |t|
    t.integer  "trip_id"
    t.integer  "user_id"
    t.string   "permission"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trip_rights", ["trip_id", "user_id"], name: "index_trip_rights_on_trip_id_and_user_id", unique: true, using: :btree
  add_index "trip_rights", ["trip_id"], name: "index_trip_rights_on_trip_id", using: :btree
  add_index "trip_rights", ["user_id"], name: "index_trip_rights_on_user_id", using: :btree

  create_table "trips", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "banner_image"
    t.string   "currency_code", default: "aud"
    t.string   "map"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
