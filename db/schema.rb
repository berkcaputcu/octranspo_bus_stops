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

ActiveRecord::Schema.define(:version => 20130706143656) do

  create_table "routes", :force => true do |t|
    t.integer  "no"
    t.string   "direction"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stop_times", :force => true do |t|
    t.integer  "stop_id"
    t.integer  "route_id"
    t.integer  "time_left1"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "time_left2"
    t.integer  "time_left3"
  end

  add_index "stop_times", ["stop_id", "route_id"], :name => "index_stop_times_on_stop_id_and_route_id", :unique => true

  create_table "stops", :force => true do |t|
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.datetime "expires_at"
    t.decimal  "lat",           :precision => 10, :scale => 6
    t.decimal  "long",          :precision => 10, :scale => 6
    t.integer  "refresh_count",                                :default => 0
  end

end
