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

ActiveRecord::Schema.define(version: 20171024121817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "followings", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insta_accounts", force: :cascade do |t|
    t.string "name"
    t.string "follower"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partner_insta_account_followings", force: :cascade do |t|
    t.date "followed_at"
    t.boolean "unfollow", default: false
    t.date "unfollowed_at"
    t.integer "following_id"
    t.integer "partner_insta_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["following_id"], name: "index_partner_insta_account_followings_on_following_id"
    t.index ["partner_insta_account_id"], name: "partner_insta_account_followings_index"
  end

  create_table "partner_insta_accounts", force: :cascade do |t|
    t.bigint "insta_account_id"
    t.bigint "partner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["insta_account_id"], name: "index_partner_insta_accounts_on_insta_account_id"
    t.index ["partner_id"], name: "index_partner_insta_accounts_on_partner_id"
  end

  create_table "partners", force: :cascade do |t|
    t.string "user_name"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
