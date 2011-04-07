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

ActiveRecord::Schema.define(:version => 20110407052356) do

  create_table "label_posts", :force => true do |t|
    t.integer  "label_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "label_posts", ["label_id", "post_id"], :name => "index_label_posts_on_label_id_and_post_id", :unique => true
  add_index "label_posts", ["label_id"], :name => "index_label_posts_on_label_id"
  add_index "label_posts", ["post_id"], :name => "index_label_posts_on_post_id"

  create_table "labels", :force => true do |t|
    t.string   "label_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body",       :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "display_name"
    t.string   "email"
    t.boolean  "admin",              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
  end

  add_index "users", ["display_name"], :name => "index_users_on_display_name", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
