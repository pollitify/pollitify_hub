# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_13_094017) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pg_catalog.plpgsql"
  enable_extension "postgis"

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "fid"
    t.string "name_ascii"
    t.string "state_fid"
    t.string "state_name"
    t.integer "county_fips"
    t.string "county_name"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.geography "coordinates", limit: {srid: 4326, type: "st_point", geographic: true}
    t.integer "population"
    t.decimal "density"
    t.string "source"
    t.boolean "military"
    t.boolean "incorporated"
    t.string "timezone"
    t.integer "ranking"
    t.integer "external_fid"
    t.bigint "state_id"
    t.text "zips"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "county_id"
    t.index ["county_id"], name: "index_cities_on_county_id"
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "congressional_districts", force: :cascade do |t|
    t.string "name"
    t.string "key_city"
    t.string "key_county"
    t.bigint "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_congressional_districts_on_state_id"
  end

  create_table "counties", force: :cascade do |t|
    t.string "name"
    t.string "name_ascii"
    t.string "name_full"
    t.string "county_fips"
    t.bigint "state_id", null: false
    t.string "state_abbreviation"
    t.string "state_name"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.geography "coordinates", limit: {srid: 4326, type: "st_point", geographic: true}
    t.integer "population"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "zips"
    t.index ["state_id"], name: "index_counties_on_state_id"
  end

  create_table "domains", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name"
    t.string "fid"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_event_types_on_organization_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.bigint "event_type_id"
    t.datetime "event_start_at"
    t.datetime "event_end_at"
    t.string "address1"
    t.string "address2"
    t.citext "city_name"
    t.bigint "state_id", null: false
    t.bigint "organization_id"
    t.string "organization_fid"
    t.string "slug"
    t.string "fid"
    t.bigint "congressional_district_id"
    t.boolean "recurring", default: false
    t.text "recurrence"
    t.string "url"
    t.string "mobilize_url"
    t.boolean "is_suggested_event"
    t.text "pasted_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.citext "county_name"
    t.string "location"
    t.string "organizing_group"
    t.string "event_type_name"
    t.string "notes"
    t.date "date_start_at"
    t.time "time_start_at"
    t.text "source_data"
    t.bigint "city_id"
    t.bigint "county_id"
    t.index ["city_id"], name: "index_events_on_city_id"
    t.index ["congressional_district_id"], name: "index_events_on_congressional_district_id"
    t.index ["county_id"], name: "index_events_on_county_id"
    t.index ["event_type_id"], name: "index_events_on_event_type_id"
    t.index ["organization_id"], name: "index_events_on_organization_id"
    t.index ["state_id", "city_name", "event_start_at"], name: "index_events_on_state_id_and_city_name_and_event_start_at"
    t.index ["state_id"], name: "index_events_on_state_id"
  end

  create_table "feature_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.string "fid"
    t.bigint "feature_category_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.boolean "active", default: true
    t.index ["feature_category_id"], name: "index_features_on_feature_category_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "fid"
    t.boolean "active", default: true
    t.bigint "secure_chat_system_id", null: false
    t.string "billing"
    t.string "city"
    t.string "state"
    t.string "organization_website_url"
    t.string "organization_website_domain"
    t.bigint "domain_id", null: false
    t.string "sub_domain"
    t.string "polly_domain"
    t.string "polly_url"
    t.text "features"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "use_pollitify_base_domain"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "username"
    t.string "password"
    t.index ["domain_id"], name: "index_organizations_on_domain_id"
    t.index ["secure_chat_system_id"], name: "index_organizations_on_secure_chat_system_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "secure_chat_systems", force: :cascade do |t|
    t.string "name"
    t.string "fid"
    t.string "url"
    t.string "icon_url"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.string "fid"
    t.integer "population"
    t.integer "congressional_district_count"
    t.string "wikipedia_congressional_district_url"
    t.string "wikipedia_congressional_district_map_url"
    t.integer "counties_count"
    t.string "townships_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.datetime "date_of_birth"
    t.string "role", default: "user", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cities", "counties"
  add_foreign_key "cities", "states"
  add_foreign_key "congressional_districts", "states"
  add_foreign_key "counties", "states"
  add_foreign_key "event_types", "organizations"
  add_foreign_key "events", "cities"
  add_foreign_key "events", "congressional_districts"
  add_foreign_key "events", "counties"
  add_foreign_key "events", "event_types"
  add_foreign_key "events", "organizations"
  add_foreign_key "events", "states"
  add_foreign_key "organizations", "domains"
  add_foreign_key "organizations", "secure_chat_systems"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
