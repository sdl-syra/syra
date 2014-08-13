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

ActiveRecord::Schema.define(version: 20140812094133) do

  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.string   "label"
    t.string   "glyph_cat"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "addresses", force: true do |t|
    t.string   "label"
    t.float    "x"
    t.float    "y"
    t.string   "region"
    t.string   "ville"
    t.float    "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentifications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
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

  create_table "followings", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hobbies", force: true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hobbies_users", id: false, force: true do |t|
    t.integer "hobby_id"
    t.integer "user_id"
  end

  create_table "levels", force: true do |t|
    t.integer  "levelUser"
    t.integer  "XPUser"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "levels", ["user_id"], name: "index_levels_on_user_id"

  create_table "notifications", force: true do |t|
    t.string   "label"
    t.string   "glyph_cat"
    t.string   "url"
    t.date     "date"
    t.boolean  "is_checked"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "opinions", force: true do |t|
    t.text     "avis"
    t.integer  "note"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opinions", ["service_id"], name: "index_opinions_on_service_id"

  create_table "propositions", force: true do |t|
    t.boolean  "isPaid"
    t.boolean  "isAccepted"
    t.text     "motifCancelled"
    t.date     "proposition"
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
    t.string   "code"
  end

  add_index "propositions", ["service_id"], name: "index_propositions_on_service_id"
  add_index "propositions", ["user_id"], name: "index_propositions_on_user_id"

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "replies", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tread_id"
  end

  create_table "reports", force: true do |t|
    t.string   "category"
    t.text     "content"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "guilty"
    t.integer  "user_id"
  end

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
    t.string   "image"
    t.string   "address"
    t.boolean  "private"
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

  create_table "treads", force: true do |t|
    t.text     "subject"
    t.integer  "user_id"
    t.integer  "hobby_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_hobbies", force: true do |t|
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "lastName"
    t.string   "email"
    t.integer  "money",                  default: 0
    t.string   "password"
    t.string   "phone"
    t.text     "biography"
    t.boolean  "isPremium"
    t.date     "birthday"
    t.integer  "level_id"
    t.integer  "success_id"
    t.integer  "address_id"
    t.boolean  "isAdmin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar"
    t.boolean  "accept_conditions"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "isBanned"
    t.text     "banReason"
  end

  add_index "users", ["address_id"], name: "index_users_on_address_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["level_id"], name: "index_users_on_level_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["success_id"], name: "index_users_on_success_id"

  create_table "users_hobbies", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "hobby_id"
  end

end
