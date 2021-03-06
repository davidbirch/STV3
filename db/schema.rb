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

ActiveRecord::Schema.define(:version => 20120930051017) do

  create_table "channels", :force => true do |t|
    t.string   "xmltv_id"
    t.string   "channel_name"
    t.string   "channel_short_name"
    t.string   "channel_logo_url"
    t.string   "channel_free_or_pay"
    t.string   "slug"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "log_entries", :force => true do |t|
    t.string   "level"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "parameters", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "programs", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "category"
    t.string   "description"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.string   "region_name"
    t.integer  "region_id"
    t.string   "sport_name"
    t.integer  "sport_id"
    t.string   "channel_xmltv_id"
    t.integer  "channel_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "raw_channels", :force => true do |t|
    t.string   "xmltv_id"
    t.string   "channel_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "raw_programs", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "category"
    t.string   "description"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.string   "region_name"
    t.string   "channel_xmltv_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "regions", :force => true do |t|
    t.string   "region_name"
    t.string   "slug"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rules", :force => true do |t|
    t.string   "rule_type"
    t.integer  "priority"
    t.string   "value"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "channel_id"
    t.string   "channel_xmltv_id"
    t.integer  "sport_id"
    t.string   "sport_name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "sports", :force => true do |t|
    t.string   "sport_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
