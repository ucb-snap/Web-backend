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

ActiveRecord::Schema.define(version: 20150426004447) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "comment_time"
    t.string   "content"
  end

  create_table "conversations", force: :cascade do |t|
  end

  create_table "course_students", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
  end

  create_table "course_teachers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "privacy"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "message_time"
    t.text     "content"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "privacy"
  end

  create_table "user_conversations", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "conversation_id"
  end

  create_table "user_projects", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
