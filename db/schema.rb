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

ActiveRecord::Schema.define(version: 20140808082858) do

  create_table "diaries", force: true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "user_created_at"
    t.datetime "user_updated_at"
  end

  create_table "templates", force: true do |t|
    t.integer  "user_id"
    t.text     "format"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "user_created_at"
    t.datetime "user_updated_at"
    t.string   "name"
    t.decimal  "selected",        precision: 10, scale: 0
  end

  create_table "users", force: true do |t|
    t.string   "username",      null: false
    t.string   "passwd",        null: false
    t.string   "nickname"
    t.string   "portrait_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

end
