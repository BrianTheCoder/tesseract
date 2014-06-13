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

ActiveRecord::Schema.define(:version => 20121020035543) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "billing_info"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "accounts", ["slug"], :name => "index_accounts_on_slug", :unique => true

  create_table "images", :force => true do |t|
    t.string   "file"
    t.integer  "width"
    t.integer  "height"
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "memberships", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "account_id"
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "access"
    t.datetime "accepted_at"
    t.integer  "inviter_id"
    t.string   "token"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "memberships", ["account_id", "user_id", "project_id"], :name => "index_memberships_on_account_id_and_user_id_and_project_id", :unique => true
  add_index "memberships", ["project_id", "email"], :name => "index_memberships_on_project_id_and_email", :unique => true

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "regions", :force => true do |t|
    t.string   "identifier"
    t.integer  "x"
    t.integer  "y"
    t.integer  "width"
    t.integer  "height"
    t.integer  "image_id"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "services", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.text     "credentials"
    t.text     "info"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "services", ["provider", "uid"], :name => "index_services_on_provider_and_uid", :unique => true
  add_index "services", ["user_id"], :name => "index_services_on_user_id"

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
    t.string   "authentication_token"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "active"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
