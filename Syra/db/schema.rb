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

ActiveRecord::Schema.define(version: 20140124163913) do

  create_table "addresses", force: true do |t|
    t.integer  "number"
    t.string   "street"
    t.string   "postalCode"
    t.string   "town"
    t.float    "x"
    t.float    "y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", force: true do |t|
    t.integer  "note"
    t.text     "comment"
    t.integer  "proposition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "evaluations", ["proposition_id"], name: "index_evaluations_on_proposition_id"

  create_table "hobbies", force: true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.integer  "levelUser"
    t.integer  "XPUser"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "levels", ["user_id"], name: "index_levels_on_user_id"

  create_table "propositions", force: true do |t|
    t.boolean  "isPaid"
    t.boolean  "isAccepted"
    t.boolean  "motifCancelled"
    t.date     "proposition"
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "propositions", ["service_id"], name: "index_propositions_on_service_id"
  add_index "propositions", ["user_id"], name: "index_propositions_on_user_id"

  create_table "services", force: true do |t|
    t.string   "title"
    t.integer  "price"
    t.text     "description"
    t.text     "disponibility"
    t.boolean  "isGiven"
    t.boolean  "isFinished"
    t.integer  "address_id"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["address_id"], name: "index_services_on_address_id"
  add_index "services", ["category_id"], name: "index_services_on_category_id"
  add_index "services", ["user_id"], name: "index_services_on_user_id"

  create_table "successes", force: true do |t|
    t.string   "label"
    t.string   "urlImageValidate"
    t.string   "urlImageUnvalidate"
    t.boolean  "locked"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "successes", ["user_id"], name: "index_successes_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "lastName"
    t.string   "email"
    t.string   "money"
    t.string   "password"
    t.string   "phone"
    t.text     "biography"
    t.boolean  "isPremium"
    t.integer  "age"
    t.integer  "level_id"
    t.integer  "success_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
  end

  add_index "users", ["address_id"], name: "index_users_on_address_id"
  add_index "users", ["level_id"], name: "index_users_on_level_id"
  add_index "users", ["success_id"], name: "index_users_on_success_id"

end
