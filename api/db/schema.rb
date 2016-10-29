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

ActiveRecord::Schema.define(version: 20161029200000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alert_types", id: :bigserial, force: :cascade do |t|
    t.string   "name"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buildings", id: :bigserial, force: :cascade do |t|
    t.integer  "location_id",      limit: 8
    t.string   "title"
    t.string   "address"
    t.string   "zipcode"
    t.string   "image_url"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "thumbnail_url"
    t.integer  "thumbnail_width"
    t.integer  "thumbnail_height"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "bulletins", id: :bigserial, force: :cascade do |t|
    t.integer  "location_id",      limit: 8
    t.string   "title"
    t.string   "description"
    t.datetime "valid_from"
    t.datetime "valid_to"
    t.string   "image_url"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "thumbnail_url"
    t.integer  "thumbnail_width"
    t.integer  "thumbnail_height"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "client_resource_details", id: :bigserial, force: :cascade do |t|
    t.integer  "client_resource_id", limit: 8
    t.string   "unique_name"
    t.string   "display_text"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "client_resources", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_default", default: false
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "country_code"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "customers", id: :bigserial, force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.string   "secret_key"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
  end

  create_table "devices", id: :bigserial, force: :cascade do |t|
    t.string   "token"
    t.string   "platform"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", id: :bigserial, force: :cascade do |t|
    t.float    "longitude"
    t.float    "latitude"
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "country_code"
    t.string   "street_alerts_rss_feed_url"
    t.boolean  "has_upcomming_events"
    t.boolean  "has_request_service"
    t.boolean  "has_location_info"
    t.boolean  "has_street_alerts"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "client_resource_id",         limit: 8
  end

  create_table "news_feeds", id: :bigserial, force: :cascade do |t|
    t.integer  "location_id", limit: 8
    t.string   "rss_url"
    t.string   "identity"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "users", id: :bigserial, force: :cascade do |t|
    t.string   "uuid"
    t.string   "name"
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
