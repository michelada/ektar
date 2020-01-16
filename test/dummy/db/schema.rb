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

ActiveRecord::Schema.define(version: 2020_01_16_171710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_enum :role, [
    "admin",
    "member",
  ]

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "ektar_memberships", force: :cascade do |t|
    t.bigint "ektar_organization_id", null: false
    t.bigint "ektar_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.enum "role", default: "member", null: false, enum_name: "role"
    t.boolean "active", default: true, null: false
    t.index ["ektar_organization_id"], name: "index_ektar_memberships_on_ektar_organization_id"
    t.index ["ektar_user_id"], name: "index_ektar_memberships_on_ektar_user_id"
  end

  create_table "ektar_organizations", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "enable", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "global_id", default: -> { "uuid_generate_v4()" }, null: false
    t.bigint "ektar_plan_id"
    t.index ["ektar_plan_id"], name: "index_ektar_organizations_on_ektar_plan_id"
    t.index ["global_id"], name: "index_ektar_organizations_on_global_id", unique: true
    t.index ["name"], name: "index_ektar_organizations_on_name", unique: true
  end

  create_table "ektar_plans", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "free", default: false, null: false
    t.integer "trial", default: 0, null: false
    t.boolean "active", default: true, null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "MXN", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ektar_profiles", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "ektar_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ektar_user_id"], name: "index_ektar_profiles_on_ektar_user_id"
    t.index ["name"], name: "index_ektar_profiles_on_name", unique: true
  end

  create_table "ektar_users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.bigint "ektar_organization_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "global_id", default: -> { "uuid_generate_v4()" }, null: false
    t.boolean "super_admin", default: false
    t.index ["ektar_organization_id"], name: "index_ektar_users_on_ektar_organization_id"
    t.index ["email"], name: "index_ektar_users_on_email", unique: true
    t.index ["global_id"], name: "index_ektar_users_on_global_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ektar_memberships", "ektar_organizations"
  add_foreign_key "ektar_memberships", "ektar_users"
  add_foreign_key "ektar_profiles", "ektar_users"
  add_foreign_key "ektar_users", "ektar_organizations"
end
