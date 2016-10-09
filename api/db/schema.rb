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

ActiveRecord::Schema.define(version: 201604270000001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chatrooms", id: :bigserial, force: :cascade do |t|
    t.string   "name"
    t.string   "chatroom_type"
    t.string   "uuid"
    t.integer  "user_id",                 limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "float_count",                       default: 0
    t.datetime "deleted_at"
    t.datetime "content_changed_at"
    t.integer  "sink_count",                        default: 0
    t.boolean  "has_messages",                      default: false
    t.boolean  "anonymous_post",                    default: false
    t.integer  "flag_count"
    t.datetime "flag_depot_expired_date"
  end

  create_table "devices", id: :bigserial, force: :cascade do |t|
    t.integer  "user_id",      limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "client_os"
    t.string   "device_token"
  end

  create_table "flag_logs", id: :bigserial, force: :cascade do |t|
    t.integer  "chatroom_id",  limit: 8
    t.integer  "user_id",      limit: 8
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_primary"
    t.boolean  "is_agreed"
    t.boolean  "is_disagreed"
  end

  create_table "invite_trackings", id: :bigserial, force: :cascade do |t|
    t.integer  "user_id",         limit: 8
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "activation_code"
    t.string   "name"
  end

  create_table "keys", id: :bigserial, force: :cascade do |t|
    t.integer  "key_type"
    t.boolean  "verified",                    default: false
    t.string   "value"
    t.string   "password"
    t.integer  "user_id",           limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "verification_code"
  end

  create_table "memberships", id: :bigserial, force: :cascade do |t|
    t.boolean  "read",                  default: false
    t.integer  "user_id",     limit: 8,                 null: false
    t.integer  "chatroom_id", limit: 8,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "selficon_id", limit: 8
  end

  create_table "messages", id: :bigserial, force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id",          limit: 8
    t.integer  "chatroom_id",      limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "media_url"
    t.string   "media_type"
    t.string   "link_type"
    t.text     "link_thumbnail"
    t.text     "link_title"
    t.text     "link_url"
    t.integer  "photo_width",                default: 0
    t.integer  "photo_height",               default: 0
    t.integer  "thumbnail_width",            default: 0
    t.integer  "thumbnail_height",           default: 0
    t.string   "uuid"
    t.string   "font_name"
    t.integer  "selficon_id",      limit: 8
  end

  create_table "notification_settings", id: :bigserial, force: :cascade do |t|
    t.integer  "user_id",                     limit: 8
    t.boolean  "send_message_to_joined_post",           default: true
    t.boolean  "send_private_message",                  default: true
    t.boolean  "following_send_post",                   default: true
    t.boolean  "someone_follow_me",                     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", id: :bigserial, force: :cascade do |t|
    t.integer  "notification_type"
    t.boolean  "is_new",                      default: true
    t.integer  "item_id",           limit: 8
    t.integer  "user_id",           limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id",        limit: 8
    t.boolean  "is_counted",                  default: false
  end

  create_table "ratings", id: :bigserial, force: :cascade do |t|
    t.integer  "rating_type"
    t.integer  "user_id",     limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id",     limit: 8
    t.boolean  "floatted",              default: false
    t.boolean  "sinked",                default: false
  end

  create_table "selficons", id: :bigserial, force: :cascade do |t|
    t.integer  "user_id",      limit: 8
    t.string   "url"
    t.boolean  "is_profile",             default: false
    t.boolean  "is_anonymous",           default: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_deleted",             default: false
  end

  create_table "subscriptions", id: :bigserial, force: :cascade do |t|
    t.integer  "user_id",    limit: 8
    t.integer  "item_id",    limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trouble_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "trouble_user_id"
    t.boolean  "is_blocked"
    t.boolean  "is_muted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :bigserial, force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.string   "website"
    t.text     "bio"
    t.string   "language"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "birthday",          default: "1/1/2000"
    t.string   "email"
    t.integer  "provider_type"
    t.string   "password"
    t.boolean  "verified"
    t.string   "verification_code"
    t.boolean  "share_birthday"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

end
