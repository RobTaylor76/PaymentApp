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

ActiveRecord::Schema.define(version: 20171031192908) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.text     "stripe_pk"
    t.text     "stripe_sk"
    t.text     "paypal_client"
    t.text     "paypal_secret"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "type"
    t.string   "status"
    t.string   "email"
    t.string   "description"
    t.datetime "date"
    t.datetime "paid_at"
    t.decimal  "amount",           precision: 10, scale: 2
    t.decimal  "amount_requested", precision: 10, scale: 2
    t.decimal  "amount_received",  precision: 10, scale: 2
    t.decimal  "amount_fees",      precision: 10, scale: 2
    t.string   "external_id"
    t.string   "guid"
    t.integer  "account_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.text     "status_message"
    t.index ["account_id"], name: "index_payments_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "account_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["account_id"], name: "index_users_on_account_id"
  end

end
