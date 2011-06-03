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

ActiveRecord::Schema.define(:version => 20110603121924) do

  create_table "articles", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "synopsis"
    t.text     "body"
    t.boolean  "published",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.integer  "category_id",  :default => 1
  end

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "comments", :force => true do |t|
    t.integer  "entry_id"
    t.integer  "user_id"
    t.string   "guest_name"
    t.string   "guest_email"
    t.string   "guest_url"
    t.text     "body"
    t.datetime "created_at"
  end

  add_index "comments", ["entry_id"], :name => "index_comments_on_entry_id"

  create_table "entries", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "comments_count", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["user_id"], :name => "index_entries_on_user_id"

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count", :default => 0, :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
  end

  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count", :default => 0, :null => false
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"

  create_table "users", :force => true do |t|
    t.string   "username",        :limit => 64,                    :null => false
    t.string   "email",           :limit => 128,                   :null => false
    t.string   "hashed_password", :limit => 64
    t.boolean  "enabled",                        :default => true, :null => false
    t.text     "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_login_at"
    t.integer  "posts_count",                    :default => 0,    :null => false
    t.integer  "entries_count",                  :default => 0,    :null => false
    t.string   "blog_title"
    t.boolean  "enable_comments",                :default => true
  end

  add_index "users", ["username"], :name => "index_users_on_username"

end
