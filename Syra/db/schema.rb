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

ActiveRecord::Schema.define(version: 20140120175625) do

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "lastName"
    t.string   "email"
    t.string   "money"
    t.string   "password"
    t.text     "biography"
    t.boolean  "isPremium"
    t.integer  "level_id"
    t.integer  "success_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["address_id"], name: "index_users_on_address_id"
  add_index "users", ["level_id"], name: "index_users_on_level_id"
  add_index "users", ["success_id"], name: "index_users_on_success_id"

end
