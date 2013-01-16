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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130103184649) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "festival_id"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "festival_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "events", ["festival_id"], :name => "index_events_on_festival_id"

  create_table "festivals", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.float    "lat"
    t.float    "long"
    t.date     "date"
    t.string   "genre"
    t.string   "website"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lineups", :force => true do |t|
    t.integer  "user_id"
    t.integer  "festival_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "lineups", ["festival_id"], :name => "index_lineups_on_festival_id"
  add_index "lineups", ["user_id"], :name => "index_lineups_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "password_hash"
    t.string   "password_salt"
  end

end
