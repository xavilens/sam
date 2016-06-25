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

ActiveRecord::Schema.define(version: 20160625214906) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",          limit: 4,   null: false
    t.integer  "activity_type_id", limit: 4,   null: false
    t.string   "description",      limit: 255, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "activities", ["activity_type_id"], name: "index_activities_on_activity_type_id", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "activity_types", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "band_statuses", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "bands", force: :cascade do |t|
    t.integer  "genre_1_id",     limit: 4, null: false
    t.integer  "genre_2_id",     limit: 4
    t.integer  "genre_3_id",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "band_status_id", limit: 4
  end

  add_index "bands", ["genre_1_id"], name: "index_bands_on_genre_1_id", using: :btree
  add_index "bands", ["genre_2_id"], name: "index_bands_on_genre_2_id", using: :btree
  add_index "bands", ["genre_3_id"], name: "index_bands_on_genre_3_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id",    limit: 4,                     null: false
    t.integer  "user_id",    limit: 4,                     null: false
    t.text     "body",       limit: 65535,                 null: false
    t.boolean  "edited",                   default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "user_1_id",  limit: 4,   null: false
    t.integer  "user_2_id",  limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "subject",    limit: 255, null: false
  end

  add_index "conversations", ["user_1_id"], name: "index_conversations_on_user_1_id", using: :btree
  add_index "conversations", ["user_2_id"], name: "index_conversations_on_user_2_id", using: :btree

  create_table "delegated_users", force: :cascade do |t|
    t.integer  "sign_in_count",      limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip", limit: 255
    t.string   "last_sign_in_ip",    limit: 255
    t.integer  "delegated_user",     limit: 4,                   null: false
    t.integer  "current_user",       limit: 4,                   null: false
    t.boolean  "active",                         default: false, null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "delegated_users", ["current_user"], name: "index_delegated_users_on_current_user", unique: true, using: :btree
  add_index "delegated_users", ["delegated_user"], name: "index_delegated_users_on_delegated_user", using: :btree

  create_table "event_participants", force: :cascade do |t|
    t.integer  "event_id",    limit: 4, null: false
    t.integer  "participant", limit: 4, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "event_participants", ["participant"], name: "index_event_participants_on_participant", using: :btree

  create_table "event_statuses", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",             limit: 255,               null: false
    t.string   "descripcion",      limit: 255
    t.date     "date",                                       null: false
    t.time     "time",                                       null: false
    t.integer  "event_status_id",  limit: 4,                 null: false
    t.string   "street",           limit: 255,               null: false
    t.string   "city",             limit: 255,               null: false
    t.string   "state",            limit: 255,               null: false
    t.string   "country",          limit: 255,               null: false
    t.integer  "max_participants", limit: 4
    t.decimal  "pvp",                          precision: 2
    t.integer  "creator_id",       limit: 4,                 null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "event_type_id",    limit: 4
    t.integer  "sala_id",          limit: 4
  end

  add_index "events", ["creator_id"], name: "index_events_on_creator_id", using: :btree
  add_index "events", ["event_status_id"], name: "index_events_on_event_status_id", using: :btree
  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id", using: :btree
  add_index "events", ["sala_id"], name: "index_events_on_sala_id", using: :btree

  create_table "followships", force: :cascade do |t|
    t.integer  "leader_id",   limit: 4, null: false
    t.integer  "follower_id", limit: 4, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "followships", ["follower_id"], name: "index_followships_on_follower_id", using: :btree
  add_index "followships", ["leader_id"], name: "index_followships_on_leader_id", using: :btree

  create_table "genres", force: :cascade do |t|
    t.string "name",     limit: 255, null: false
    t.string "category", limit: 255, null: false
  end

  create_table "instruments", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "main_posts", force: :cascade do |t|
    t.integer  "post_id",    limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "main_posts", ["post_id"], name: "index_main_posts_on_post_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.integer  "band_id",       limit: 4, null: false
    t.integer  "musician_id",   limit: 4, null: false
    t.integer  "instrument_id", limit: 4, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "members", ["band_id"], name: "index_members_on_band_id", using: :btree
  add_index "members", ["instrument_id"], name: "index_members_on_instrument_id", using: :btree
  add_index "members", ["musician_id"], name: "index_members_on_musician_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "author_id",       limit: 4,     null: false
    t.text     "body",            limit: 65535, null: false
    t.integer  "conversation_id", limit: 4,     null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "messages", ["author_id"], name: "fk_rails_fc36125d0f", using: :btree
  add_index "messages", ["author_id"], name: "index_messages_on_author_id", using: :btree
  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree

  create_table "musician_knowledges", force: :cascade do |t|
    t.integer  "musician_id",  limit: 4, null: false
    t.integer  "knowledge_id", limit: 4, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "level_id",     limit: 4
  end

  add_index "musician_knowledges", ["knowledge_id"], name: "index_musician_knowledges_on_knowledge_id", using: :btree
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

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255,                   null: false
    t.integer  "user_id",    limit: 4,                     null: false
    t.text     "body",       limit: 65535,                 null: false
    t.boolean  "published",                default: false, null: false
    t.boolean  "edited",                   default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "rehearsal_studio_reviews", force: :cascade do |t|
    t.string   "title",               limit: 255,               null: false
    t.string   "description",         limit: 255
    t.decimal  "rate",                            precision: 1, null: false
    t.decimal  "room_dimension",                  precision: 2
    t.decimal  "room_price",                      precision: 2
    t.string   "avaliability",        limit: 255
    t.boolean  "equipped_room"
    t.boolean  "shared_room"
    t.integer  "bands_in_room",       limit: 4
    t.integer  "user_id",             limit: 4
    t.integer  "rehearsal_studio_id", limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "rehearsal_studio_users", force: :cascade do |t|
    t.integer  "rehearsal_studio_id", limit: 4, null: false
    t.integer  "user_id",             limit: 4, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "rehearsal_studio_users", ["rehearsal_studio_id"], name: "index_rehearsal_studio_users_on_rehearsal_studio_id", using: :btree
  add_index "rehearsal_studio_users", ["user_id"], name: "index_rehearsal_studio_users_on_user_id", using: :btree

  create_table "rehearsal_studios", force: :cascade do |t|
    t.string   "name",            limit: 255,               null: false
    t.string   "street",          limit: 255,               null: false
    t.string   "city",            limit: 255,               null: false
    t.string   "state",           limit: 255,               null: false
    t.string   "country",         limit: 255,               null: false
    t.integer  "rooms_avaliable", limit: 4
    t.integer  "creator_id",      limit: 4,                 null: false
    t.decimal  "total_rate",                  precision: 2
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "rehearsal_studios", ["creator_id"], name: "index_rehearsal_studios_on_creator_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "sala_genres", force: :cascade do |t|
    t.integer  "sala_id",    limit: 4, null: false
    t.integer  "genre_id",   limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "sala_genres", ["genre_id"], name: "index_sala_genres_on_genre_id", using: :btree
  add_index "sala_genres", ["sala_id"], name: "index_sala_genres_on_sala_id", using: :btree

  create_table "sala_reviews", force: :cascade do |t|
    t.string   "title",        limit: 255,                                           null: false
    t.text     "desciption",   limit: 65535
    t.boolean  "rent_paid",                                          default: false
    t.decimal  "rent_price",                 precision: 5, scale: 2
    t.decimal  "service_rate",               precision: 5, scale: 1,                 null: false
    t.decimal  "gear_rate",                  precision: 5, scale: 1,                 null: false
    t.decimal  "total_rate",                 precision: 5, scale: 1,                 null: false
    t.decimal  "money_earned",               precision: 5, scale: 2
    t.integer  "user_id",      limit: 4,                                             null: false
    t.integer  "sala_id",      limit: 4,                                             null: false
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
  end

  add_index "sala_reviews", ["sala_id"], name: "index_sala_reviews_on_sala_id", using: :btree
  add_index "sala_reviews", ["user_id"], name: "index_sala_reviews_on_user_id", using: :btree

  create_table "sala_users", force: :cascade do |t|
    t.integer  "sala_id",    limit: 4, null: false
    t.integer  "user_id",    limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "sala_users", ["sala_id"], name: "index_sala_users_on_sala_id", using: :btree
  add_index "sala_users", ["user_id"], name: "index_sala_users_on_user_id", using: :btree

  create_table "salas", force: :cascade do |t|
    t.string   "name",         limit: 255,                            null: false
    t.string   "street",       limit: 255,                            null: false
    t.string   "city",         limit: 255,                            null: false
    t.string   "state",        limit: 255,                            null: false
    t.string   "country",      limit: 255,                            null: false
    t.integer  "creator_id",   limit: 4,                              null: false
    t.integer  "n_reviews",    limit: 4,                  default: 0, null: false
    t.decimal  "total_rating",             precision: 10
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "salas", ["creator_id"], name: "index_salas_on_creator_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "name",                   limit: 255,              null: false
    t.string   "city",                   limit: 255,              null: false
    t.string   "state",                  limit: 255,              null: false
    t.string   "country",                limit: 255,              null: false
    t.integer  "profileable_id",         limit: 4,                null: false
    t.string   "profileable_type",       limit: 255,              null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "role_id",                limit: 4,                null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "activities", "activity_types"
  add_foreign_key "activities", "users"
  add_foreign_key "bands", "genres", column: "genre_1_id"
  add_foreign_key "bands", "genres", column: "genre_2_id"
  add_foreign_key "bands", "genres", column: "genre_3_id"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "conversations", "users", column: "user_1_id"
  add_foreign_key "conversations", "users", column: "user_2_id"
  add_foreign_key "delegated_users", "users", column: "current_user"
  add_foreign_key "delegated_users", "users", column: "delegated_user"
  add_foreign_key "event_participants", "users", column: "participant"
  add_foreign_key "events", "event_statuses"
  add_foreign_key "events", "event_types"
  add_foreign_key "events", "salas"
  add_foreign_key "events", "users", column: "creator_id"
  add_foreign_key "followships", "users", column: "follower_id"
  add_foreign_key "followships", "users", column: "leader_id"
  add_foreign_key "main_posts", "posts"
  add_foreign_key "members", "bands"
  add_foreign_key "members", "instruments"
  add_foreign_key "members", "musicians"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users", column: "author_id"
  add_foreign_key "musician_knowledges", "instruments", column: "knowledge_id"
  add_foreign_key "musician_knowledges", "levels"
  add_foreign_key "musician_knowledges", "musicians"
  add_foreign_key "posts", "users"
  add_foreign_key "rehearsal_studio_users", "rehearsal_studios"
  add_foreign_key "rehearsal_studio_users", "users"
  add_foreign_key "rehearsal_studios", "users", column: "creator_id"
  add_foreign_key "sala_genres", "genres"
  add_foreign_key "sala_genres", "salas"
  add_foreign_key "sala_reviews", "salas"
  add_foreign_key "sala_reviews", "users"
  add_foreign_key "sala_users", "salas"
  add_foreign_key "sala_users", "users"
  add_foreign_key "salas", "users", column: "creator_id"
  add_foreign_key "users", "roles"
end
