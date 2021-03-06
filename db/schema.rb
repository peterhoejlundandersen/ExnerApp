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

ActiveRecord::Schema.define(version: 20190730160735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.text "image"
    t.integer "position"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "facts", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "frontpage_texts", force: :cascade do |t|
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "image_categories", force: :cascade do |t|
    t.string "name"
    t.integer "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
  end

  create_table "images", force: :cascade do |t|
    t.string "image"
    t.text "image_description"
    t.integer "image_category_id"
    t.string "photographer"
    t.text "info", default: [""], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.boolean "is_review_img", default: false
    t.boolean "draft", default: false
  end

  create_table "infos", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "work_id"
  end

  create_table "map_infos", force: :cascade do |t|
    t.text "text"
    t.decimal "lat_x", precision: 8, scale: 6
    t.decimal "lat_y", precision: 8, scale: 6
    t.string "link"
    t.string "image"
    t.bigint "work_id"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.integer "sagsnr"
    t.index ["work_id"], name: "index_map_infos_on_work_id"
  end

  create_table "pdf_categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "position"
    t.index ["slug"], name: "index_pdf_categories_on_slug", unique: true
  end

  create_table "pdfs", force: :cascade do |t|
    t.string "title"
    t.string "file"
    t.bigint "pdf_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date"
    t.string "slug"
    t.string "image"
    t.integer "position"
    t.boolean "show_not", default: false
    t.integer "opening_year"
    t.index ["pdf_category_id"], name: "index_pdfs_on_pdf_category_id"
    t.index ["slug"], name: "index_pdfs_on_slug", unique: true
  end

  create_table "texts", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "roles"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "video_url"
    t.string "link"
    t.boolean "only_link", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link_image"
    t.string "link_anker"
    t.datetime "year"
  end

  create_table "works", force: :cascade do |t|
    t.integer "sagsnr"
    t.string "name"
    t.text "description"
    t.string "address"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "opening_year"
    t.integer "competition"
    t.string "overview_img"
    t.integer "position"
    t.index ["slug"], name: "index_works_on_slug", unique: true
  end

  add_foreign_key "map_infos", "works"
end
