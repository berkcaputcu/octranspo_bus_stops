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

ActiveRecord::Schema.define(:version => 20130712175423) do

  create_table "adjusted_times", :force => true do |t|
    t.integer  "time_left"
    t.decimal  "age"
    t.decimal  "latitude",     :precision => 10, :scale => 6
    t.decimal  "longitude",    :precision => 10, :scale => 6
    t.integer  "stop_time_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "adjusted_times", ["stop_time_id"], :name => "index_adjusted_times_on_stop_time_id"

  create_table "routes", :force => true do |t|
    t.integer  "no"
    t.string   "direction"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stop_times", :force => true do |t|
    t.integer  "stop_id"
    t.integer  "route_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.boolean  "gmaps"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
