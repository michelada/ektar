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

ActiveRecord::Schema.define(version: 2019_08_06_235122) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ektar_organizations", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "enable", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_ektar_organizations_on_name", unique: true
  end

  create_table "ektar_users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.integer "role", default: 1
    t.bigint "ektar_organizations_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ektar_organizations_id"], name: "index_ektar_users_on_ektar_organizations_id"
    t.index ["email"], name: "index_ektar_users_on_email", unique: true
  end

  add_foreign_key "ektar_users", "ektar_organizations", column: "ektar_organizations_id"
end
