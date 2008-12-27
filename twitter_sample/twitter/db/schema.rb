# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081219185441) do

  create_table "follower_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follower_users", ["follower_id"], :name => "index_follower_users_on_follower_id"
  add_index "follower_users", ["user_id"], :name => "index_follower_users_on_user_id"

  create_table "statuses", :force => true do |t|
    t.boolean  "favourited",                           :default => false
    t.integer  "in_reply_to_status_id"
    t.integer  "in_reply_to_user_id"
    t.string   "source",                :limit => 50
    t.string   "source_url",            :limit => 500
    t.text     "text",                                                    :null => false
    t.boolean  "truncated",                            :default => false
    t.integer  "user_id",                                                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "description",               :limit => 140, :default => ""
    t.integer  "favourites_count",                         :default => 0,     :null => false
    t.integer  "followers_count",                          :default => 0,     :null => false
    t.boolean  "following",                                :default => false
    t.integer  "friends_count",                            :default => 0,     :null => false
    t.string   "location",                  :limit => 140, :default => ""
    t.string   "profile_image_url",         :limit => 500
    t.boolean  "protected",                                :default => false
    t.integer  "users_count",                              :default => 0,     :null => false
    t.string   "time_zone",                 :limit => 140
    t.string   "url",                       :limit => 500
    t.string   "utc_offset",                :limit => 50
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
