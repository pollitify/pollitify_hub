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

ActiveRecord::Schema[8.0].define(version: 2025_08_20_165149) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pg_catalog.plpgsql"

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
    t.string "coordinates"
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

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "news_feed_item_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_feed_item_id"], name: "index_comments_on_news_feed_item_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
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
    t.string "coordinates"
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
    t.time "time_end_at"
    t.text "source_data"
    t.bigint "city_id"
    t.bigint "county_id"
    t.boolean "ada_accessible"
    t.string "state_name"
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
    t.string "fid"
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

  create_table "feed_items", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.text "summary"
    t.datetime "published_at"
    t.string "guid"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guid"], name: "index_feed_items_on_guid"
    t.index ["url"], name: "index_feed_items_on_url", unique: true
  end

  create_table "google_sheet_urls", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.text "options"
    t.datetime "last_checked_at"
    t.string "ip_address"
    t.string "user_agent"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "csv_export_url"
    t.string "gid"
    t.integer "start_at_row"
    t.index ["user_id"], name: "index_google_sheet_urls_on_user_id"
  end

  create_table "news_feed_items", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.text "summary"
    t.datetime "published_at"
    t.string "guid"
    t.string "source"
    t.bigint "news_feed_url_id"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "permalink"
    t.index ["news_feed_url_id"], name: "index_news_feed_items_on_news_feed_url_id"
  end

  create_table "news_feed_urls", force: :cascade do |t|
    t.string "name"
    t.string "rss_url"
    t.datetime "last_checked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "fid"
    t.boolean "active", default: true
    t.bigint "secure_chat_system_id", null: false
    t.string "billing"
    t.string "city"
    t.bigint "state_id"
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
    t.index ["state_id"], name: "index_organizations_on_state_id"
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

  create_table "solid_queue_blocked_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.string "concurrency_key", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.index ["concurrency_key", "priority", "job_id"], name: "index_solid_queue_blocked_executions_for_release"
    t.index ["expires_at", "concurrency_key"], name: "index_solid_queue_blocked_executions_for_maintenance"
    t.index ["job_id"], name: "index_solid_queue_blocked_executions_on_job_id", unique: true
  end

  create_table "solid_queue_claimed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "process_id"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_claimed_executions_on_job_id", unique: true
    t.index ["process_id", "job_id"], name: "index_solid_queue_claimed_executions_on_process_id_and_job_id"
  end

  create_table "solid_queue_failed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.text "error"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_failed_executions_on_job_id", unique: true
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "queue_name", null: false
    t.string "class_name", null: false
    t.text "arguments"
    t.integer "priority", default: 0, null: false
    t.string "active_job_id"
    t.datetime "scheduled_at"
    t.datetime "finished_at"
    t.string "concurrency_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_job_id"], name: "index_solid_queue_jobs_on_active_job_id"
    t.index ["class_name"], name: "index_solid_queue_jobs_on_class_name"
    t.index ["finished_at"], name: "index_solid_queue_jobs_on_finished_at"
    t.index ["queue_name", "finished_at"], name: "index_solid_queue_jobs_for_filtering"
    t.index ["scheduled_at", "finished_at"], name: "index_solid_queue_jobs_for_alerting"
  end

  create_table "solid_queue_pauses", force: :cascade do |t|
    t.string "queue_name", null: false
    t.datetime "created_at", null: false
    t.index ["queue_name"], name: "index_solid_queue_pauses_on_queue_name", unique: true
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.string "kind", null: false
    t.datetime "last_heartbeat_at", null: false
    t.bigint "supervisor_id"
    t.integer "pid", null: false
    t.string "hostname"
    t.text "metadata"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.index ["last_heartbeat_at"], name: "index_solid_queue_processes_on_last_heartbeat_at"
    t.index ["name", "supervisor_id"], name: "index_solid_queue_processes_on_name_and_supervisor_id", unique: true
    t.index ["supervisor_id"], name: "index_solid_queue_processes_on_supervisor_id"
  end

  create_table "solid_queue_ready_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_ready_executions_on_job_id", unique: true
    t.index ["priority", "job_id"], name: "index_solid_queue_poll_all"
    t.index ["queue_name", "priority", "job_id"], name: "index_solid_queue_poll_by_queue"
  end

  create_table "solid_queue_recurring_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "task_key", null: false
    t.datetime "run_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_recurring_executions_on_job_id", unique: true
    t.index ["task_key", "run_at"], name: "index_solid_queue_recurring_executions_on_task_key_and_run_at", unique: true
  end

  create_table "solid_queue_recurring_tasks", force: :cascade do |t|
    t.string "key", null: false
    t.string "schedule", null: false
    t.string "command", limit: 2048
    t.string "class_name"
    t.text "arguments"
    t.string "queue_name"
    t.integer "priority", default: 0
    t.boolean "static", default: true, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_solid_queue_recurring_tasks_on_key", unique: true
    t.index ["static"], name: "index_solid_queue_recurring_tasks_on_static"
  end

  create_table "solid_queue_scheduled_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "scheduled_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_scheduled_executions_on_job_id", unique: true
    t.index ["scheduled_at", "priority", "job_id"], name: "index_solid_queue_dispatch_all"
  end

  create_table "solid_queue_semaphores", force: :cascade do |t|
    t.string "key", null: false
    t.integer "value", default: 1, null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at"], name: "index_solid_queue_semaphores_on_expires_at"
    t.index ["key", "value"], name: "index_solid_queue_semaphores_on_key_and_value"
    t.index ["key"], name: "index_solid_queue_semaphores_on_key", unique: true
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

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cities", "counties"
  add_foreign_key "cities", "states"
  add_foreign_key "comments", "news_feed_items"
  add_foreign_key "comments", "users"
  add_foreign_key "congressional_districts", "states"
  add_foreign_key "counties", "states"
  add_foreign_key "event_types", "organizations"
  add_foreign_key "events", "cities"
  add_foreign_key "events", "congressional_districts"
  add_foreign_key "events", "counties"
  add_foreign_key "events", "event_types"
  add_foreign_key "events", "organizations"
  add_foreign_key "events", "states"
  add_foreign_key "google_sheet_urls", "users"
  add_foreign_key "news_feed_items", "news_feed_urls"
  add_foreign_key "organizations", "domains"
  add_foreign_key "organizations", "secure_chat_systems"
  add_foreign_key "solid_queue_blocked_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_claimed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_failed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_ready_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_recurring_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_scheduled_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
