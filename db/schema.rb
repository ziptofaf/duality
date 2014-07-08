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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140701221401) do

  create_table "account_logs", force: true do |t|
    t.integer  "account_id"
    t.integer  "bytes_sent"
    t.integer  "bytes_received"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote"
  end

  add_index "account_logs", ["account_id"], name: "index_account_logs_on_account_id", using: :btree

  create_table "accounts", force: true do |t|
    t.string   "login"
    t.string   "password"
    t.integer  "level"
    t.datetime "expire"
    t.integer  "user_id"
    t.integer  "server_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
  end

  add_index "accounts", ["product_id"], name: "index_accounts_on_product_id", using: :btree
  add_index "accounts", ["server_id"], name: "index_accounts_on_server_id", using: :btree
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "payments", force: true do |t|
    t.integer  "processor_id"
    t.integer  "user_id"
    t.decimal  "amount",       precision: 8, scale: 2
    t.string   "status"
    t.string   "tx"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["processor_id"], name: "index_payments_on_processor_id", using: :btree
  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "processors", force: true do |t|
    t.string   "name"
    t.integer  "usable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_processors", force: true do |t|
    t.string   "name"
    t.integer  "usable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "ProductProcessor_id"
    t.decimal  "price",               precision: 8, scale: 2
    t.string   "parameters"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  add_index "products", ["ProductProcessor_id"], name: "index_products_on_ProductProcessor_id", using: :btree

  create_table "purchases", force: true do |t|
    t.string   "name"
    t.datetime "date"
    t.decimal  "value",      precision: 7, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id", using: :btree

  create_table "recoveries", force: true do |t|
    t.integer  "user_id"
    t.datetime "expire"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recoveries", ["user_id"], name: "index_recoveries_on_user_id", using: :btree

  create_table "servers", force: true do |t|
    t.string   "ip"
    t.string   "location"
    t.integer  "capacity_max"
    t.integer  "capacity_current"
    t.string   "cert_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level"
    t.string   "certname"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.integer  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "balance",         precision: 8, scale: 2
  end

end
