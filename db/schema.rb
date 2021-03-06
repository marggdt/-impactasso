# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_22_145455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assos", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "address"
    t.string "city"
    t.string "zipcode"
    t.float "longitude"
    t.float "latitude"
    t.string "image_url"
    t.string "category"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "mission_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mission_id"], name: "index_favorites_on_mission_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "missions", force: :cascade do |t|
    t.text "description"
    t.text "web_scraper_order"
    t.text "web_scraper_start_url"
    t.string "title"
    t.string "lieu"
    t.string "type_mission"
    t.string "date_mission"
    t.string "dispo"
    t.bigint "asso_id", null: false
    t.index ["asso_id"], name: "index_missions_on_asso_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "address"
    t.string "city"
    t.string "postal_code"
    t.string "phone_number"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "favorites", "missions"
  add_foreign_key "favorites", "users"
  add_foreign_key "missions", "assos"
end
