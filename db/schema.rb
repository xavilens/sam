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

ActiveRecord::Schema.define(version: 20170414155821) do

  create_table "addresses", force: :cascade do |t|
    t.string   "addresseable_id",   limit: 255, null: false
    t.string   "street",            limit: 255
    t.string   "gaddress",          limit: 255
    t.string   "city",              limit: 255
    t.string   "region",            limit: 255
    t.string   "country",           limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "addresseable_type", limit: 255, null: false
    t.string   "municipality",      limit: 255
    t.string   "postal_code",       limit: 255
    t.string   "province",          limit: 255
  end

  add_index "addresses", ["addresseable_id"], name: "index_addresses_on_addresseable_id", using: :btree

  create_table "band_statuses", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "bands", force: :cascade do |t|
    t.integer  "genre_1_id",     limit: 4
    t.integer  "genre_2_id",     limit: 4
    t.integer  "genre_3_id",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "band_status_id", limit: 4
  end

  add_index "bands", ["genre_1_id"], name: "index_bands_on_genre_1_id", using: :btree
  add_index "bands", ["genre_2_id"], name: "index_bands_on_genre_2_id", using: :btree
  add_index "bands", ["genre_3_id"], name: "index_bands_on_genre_3_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "user_1_id",  limit: 4,   null: false
    t.integer  "user_2_id",  limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "subject",    limit: 255, null: false
  end

  add_index "conversations", ["user_1_id"], name: "index_conversations_on_user_1_id", using: :btree
  add_index "conversations", ["user_2_id"], name: "index_conversations_on_user_2_id", using: :btree

  create_table "event_participants", force: :cascade do |t|
    t.integer  "event_id",       limit: 4, null: false
    t.integer  "participant_id", limit: 4, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "event_participants", ["event_id"], name: "index_event_participants_on_event_id", using: :btree
  add_index "event_participants", ["participant_id"], name: "index_event_participants_on_participant_id", using: :btree

  create_table "event_statuses", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",             limit: 255,                 null: false
    t.text     "description",      limit: 65535
    t.date     "date",                                         null: false
    t.string   "time",             limit: 255,                 null: false
    t.integer  "event_status_id",  limit: 4,                   null: false
    t.integer  "max_participants", limit: 4
    t.decimal  "pvp",                            precision: 2
    t.integer  "creator_id",       limit: 4,                   null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "event_type_id",    limit: 4
    t.integer  "sala_id",          limit: 4
  end

  add_index "events", ["creator_id"], name: "index_events_on_creator_id", using: :btree
  add_index "events", ["event_status_id"], name: "index_events_on_event_status_id", using: :btree
  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id", using: :btree

  create_table "followships", force: :cascade do |t|
    t.integer  "leader_id",   limit: 4, null: false
    t.integer  "follower_id", limit: 4, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "followships", ["follower_id"], name: "index_followships_on_follower_id", using: :btree
  add_index "followships", ["leader_id"], name: "index_followships_on_leader_id", using: :btree

  create_table "genres", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "description",    limit: 65535
    t.integer  "imageable_id",   limit: 4
    t.string   "imageable_type", limit: 255
    t.string   "image",          limit: 255,   default: "", null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "images", ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree

  create_table "instruments", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "member_instruments", force: :cascade do |t|
    t.integer  "member_id",     limit: 4, null: false
    t.integer  "instrument_id", limit: 4, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "member_instruments", ["instrument_id"], name: "index_member_instruments_on_instrument_id", using: :btree
  add_index "member_instruments", ["member_id"], name: "index_member_instruments_on_member_id", using: :btree

  create_table "member_to_bands", force: :cascade do |t|
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.string   "country",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer  "band_id",     limit: 4, null: false
    t.integer  "musician_id", limit: 4, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "members", ["band_id"], name: "index_members_on_band_id", using: :btree
  add_index "members", ["musician_id"], name: "index_members_on_musician_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "author_id",       limit: 4,                     null: false
    t.text     "body",            limit: 65535,                 null: false
    t.integer  "conversation_id", limit: 4,                     null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "read",                          default: false
    t.string   "type",            limit: 255
  end

  add_index "messages", ["author_id"], name: "fk_rails_fc36125d0f", using: :btree
  add_index "messages", ["author_id"], name: "index_messages_on_author_id", using: :btree
  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree

  create_table "musician_knowledges", force: :cascade do |t|
    t.integer  "musician_id",   limit: 4, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "instrument_id", limit: 4
    t.integer  "level_id",      limit: 4
  end

  add_index "musician_knowledges", ["instrument_id"], name: "index_musician_knowledges_on_instrument_id", using: :btree
  add_index "musician_knowledges", ["level_id"], name: "index_musician_knowledges_on_level_id", using: :btree
  add_index "musician_knowledges", ["musician_id"], name: "index_musician_knowledges_on_musician_id", using: :btree

  create_table "musician_statuses", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "musicians", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "musician_status_id", limit: 4
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "social_networks_sets", force: :cascade do |t|
    t.string   "facebook_url",   limit: 255
    t.string   "website_url",    limit: 255
    t.string   "gplus_url",      limit: 255
    t.string   "instagram_url",  limit: 255
    t.string   "bandcamp",       limit: 255
    t.string   "soundcloud_url", limit: 255
    t.string   "twitter_url",    limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "youtube_url",    limit: 255
  end

  create_table "songs", force: :cascade do |t|
    t.string   "url",          limit: 255,                 null: false
    t.integer  "user_id",      limit: 4,                   null: false
    t.boolean  "in_user_page",             default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "songs", ["user_id"], name: "index_songs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "name",                   limit: 255,                null: false
    t.integer  "profileable_id",         limit: 4,                  null: false
    t.string   "profileable_type",       limit: 255,                null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "role_id",                limit: 4,                  null: false
    t.text     "bio",                    limit: 65535
    t.string   "avatar",                 limit: 255
    t.integer  "social_networks_set_id", limit: 4,                  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree
  add_index "users", ["social_networks_set_id"], name: "index_users_on_social_networks_set_id", using: :btree

  add_foreign_key "bands", "genres", column: "genre_1_id"
  add_foreign_key "bands", "genres", column: "genre_2_id"
  add_foreign_key "bands", "genres", column: "genre_3_id"
  add_foreign_key "conversations", "users", column: "user_1_id"
  add_foreign_key "conversations", "users", column: "user_2_id"
  add_foreign_key "event_participants", "events"
  add_foreign_key "event_participants", "users", column: "participant_id"
  add_foreign_key "events", "event_statuses"
  add_foreign_key "events", "event_types"
  add_foreign_key "events", "users", column: "creator_id"
  add_foreign_key "followships", "users", column: "follower_id"
  add_foreign_key "followships", "users", column: "leader_id"
  add_foreign_key "member_instruments", "instruments"
  add_foreign_key "member_instruments", "members"
  add_foreign_key "members", "bands"
  add_foreign_key "members", "musicians"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users", column: "author_id"
  add_foreign_key "musician_knowledges", "instruments"
  add_foreign_key "musician_knowledges", "levels"
  add_foreign_key "musician_knowledges", "musicians"
  add_foreign_key "songs", "users"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "social_networks_sets"
end
