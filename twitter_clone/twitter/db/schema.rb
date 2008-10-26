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

ActiveRecord::Schema.define(:version => 20081019200710) do

  create_table "statuses", :force => true do |t|
    t.boolean  "favourited",                           :default => false
    t.integer  "in_reply_to_status_id"
    t.integer  "in_reply_to_user_id"
    t.string   "source",                :limit => 50
    t.string   "source_url",            :limit => 500
    t.string   "text",                  :limit => 140
    t.boolean  "truncated",                            :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "description",       :limit => 140, :default => ""
    t.integer  "favourites_count",                 :default => 0,     :null => false
    t.integer  "followers_count",                  :default => 0,     :null => false
    t.boolean  "following",                        :default => false
    t.integer  "friends_count",                    :default => 0,     :null => false
    t.string   "location",          :limit => 140, :default => ""
    t.string   "name",              :limit => 140,                    :null => false
    t.string   "profile_image_url", :limit => 500
    t.boolean  "protected",                        :default => false
    t.integer  "statuses_count",                   :default => 0,     :null => false
    t.integer  "screen_name",       :limit => 140,                    :null => false
    t.string   "time_zone",         :limit => 140
    t.string   "url",               :limit => 500
    t.string   "utc_offset",        :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
