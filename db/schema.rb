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

ActiveRecord::Schema.define(:version => 20130121041054) do

  create_table "apply_elements", :force => true do |t|
    t.integer  "apply_info_id"
    t.integer  "element_id"
    t.text     "config_hash"
    t.string   "partial_name"
    t.integer  "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "apply_infos", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.integer  "share"
    t.integer  "backdrop_id"
    t.string   "img_url"
    t.text     "config_hash"
    t.integer  "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "attaches", :force => true do |t|
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "backdrops", :force => true do |t|
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "cid"
    t.string   "sub_appkey"
    t.string   "sns_uname"
    t.string   "sns_uimg"
    t.text     "config_hash"
    t.datetime "expires_at"
    t.string   "sns_token"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "lists", :force => true do |t|
    t.integer  "company_id"
    t.integer  "apply_info_id"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "opinions", :force => true do |t|
    t.integer  "company_id"
    t.string   "sns_uname"
    t.string   "sns_uimg"
    t.string   "desp"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "post_infos", :force => true do |t|
    t.integer  "company_id"
    t.integer  "apply_info_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "content"
    t.integer  "status"
  end

  create_table "users", :force => true do |t|
    t.string   "sns_uid"
    t.string   "sns_uname"
    t.string   "sns_uimg"
    t.string   "sns_token"
    t.datetime "expires_at"
    t.integer  "verified_type"
    t.string   "location"
    t.string   "friends"
    t.string   "statuses"
    t.string   "description"
    t.string   "label"
    t.string   "remark"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "gender"
    t.integer  "fans"
  end

end
