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

ActiveRecord::Schema.define(version: 20150413023702) do

  create_table "class_students", force: :cascade do |t|
    t.integer "snapuser_id"
    t.integer "snapclass_id"
  end

  create_table "class_teachers", force: :cascade do |t|
    t.integer "snapuser_id"
    t.integer "snapclass_id"
  end

  create_table "snapassignments", force: :cascade do |t|
    t.integer "snapclass_id"
    t.string  "title"
    t.string  "description"
  end

  create_table "snapclasses", force: :cascade do |t|
    t.string  "title"
    t.string  "description"
    t.boolean "is_public"
  end

  create_table "snapprojects", force: :cascade do |t|
    t.integer "snapuser_id"
    t.string  "tite"
    t.string  "description"
  end

  create_table "snapusers", force: :cascade do |t|
    t.string   "username"
    t.integer  "snapclass_id"
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

  add_index "snapusers", ["email"], name: "index_snapusers_on_email", unique: true
  add_index "snapusers", ["reset_password_token"], name: "index_snapusers_on_reset_password_token", unique: true

end
