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

ActiveRecord::Schema.define(version: 20160625135913) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",          limit: 4,   null: false
    t.integer  "activity_type_id", limit: 4,   null: false
    t.string   "descripcion",      limit: 255, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "activities", ["activity_type_id"], name: "index_activities_on_activity_type_id", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "activity_types", force: :cascade do |t|
    t.string "nombre", limit: 255
  end

  create_table "band_statuses", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "bands", force: :cascade do |t|
    t.integer  "genre1_id",      limit: 4, null: false
    t.integer  "genre2_id",      limit: 4
    t.integer  "genre3_id",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "band_status_id", limit: 4
  end

  add_index "bands", ["genre1_id"], name: "index_bands_on_genre1_id", using: :btree
  add_index "bands", ["genre2_id"], name: "index_bands_on_genre2_id", using: :btree
  add_index "bands", ["genre3_id"], name: "index_bands_on_genre3_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id",    limit: 4,                     null: false
    t.integer  "user_id",    limit: 4,                     null: false
    t.text     "cuerpo",     limit: 65535,                 null: false
    t.boolean  "editado",                  default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "usuario_1",  limit: 4,   null: false
    t.integer  "usuario_2",  limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "asunto",     limit: 255, null: false
  end

  add_index "conversations", ["usuario_1"], name: "index_conversations_on_usuario_1", using: :btree
  add_index "conversations", ["usuario_2"], name: "index_conversations_on_usuario_2", using: :btree

  create_table "delegated_users", force: :cascade do |t|
    t.integer  "sign_in_count",      limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip", limit: 255
    t.string   "last_sign_in_ip",    limit: 255
    t.integer  "delegated_user",     limit: 4,                   null: false
    t.integer  "current_user",       limit: 4,                   null: false
    t.boolean  "activo",                         default: false, null: false
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
    t.string "nombre", limit: 255, null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string "nombre", limit: 255
  end

  create_table "events", force: :cascade do |t|
    t.string   "nombre",            limit: 255,               null: false
    t.string   "descripcion",       limit: 255
    t.date     "fecha",                                       null: false
    t.time     "hora",                                        null: false
    t.integer  "event_status_id",   limit: 4,                 null: false
    t.string   "calle",             limit: 255,               null: false
    t.string   "ciudad",            limit: 255,               null: false
    t.string   "comunidad",         limit: 255,               null: false
    t.string   "pais",              limit: 255,               null: false
    t.integer  "max_participantes", limit: 4
    t.decimal  "pvp",                           precision: 2
    t.integer  "creador",           limit: 4,                 null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "event_type_id",     limit: 4
  end

  add_index "events", ["creador"], name: "index_events_on_creador", using: :btree
  add_index "events", ["event_status_id"], name: "index_events_on_event_status_id", using: :btree
  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id", using: :btree

  create_table "followships", force: :cascade do |t|
    t.integer  "followed_id", limit: 4, null: false
    t.integer  "follower_id", limit: 4, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "nombre",    limit: 255, null: false
    t.string "categoria", limit: 255, null: false
  end

  create_table "knowledges", force: :cascade do |t|
    t.string "nombre", limit: 255, null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string "nombre", limit: 255, null: false
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
    t.integer  "autor",           limit: 4,     null: false
    t.text     "cuerpo",          limit: 65535, null: false
    t.integer  "conversation_id", limit: 4,     null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "messages", ["autor"], name: "fk_rails_fc36125d0f", using: :btree
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
    t.string   "titulo",     limit: 255,                   null: false
    t.integer  "user_id",    limit: 4,                     null: false
    t.text     "cuerpo",     limit: 65535,                 null: false
    t.boolean  "publicado",                default: false, null: false
    t.boolean  "editado",                  default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "nombre", limit: 255, null: false
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
    t.string   "nombre",                 limit: 255,              null: false
    t.string   "ciudad",                 limit: 255,              null: false
    t.string   "comunidad",              limit: 255,              null: false
    t.string   "pais",                   limit: 255,              null: false
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
  add_foreign_key "bands", "genres", column: "genre1_id"
  add_foreign_key "bands", "genres", column: "genre2_id"
  add_foreign_key "bands", "genres", column: "genre3_id"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "conversations", "users", column: "usuario_1"
  add_foreign_key "conversations", "users", column: "usuario_2"
  add_foreign_key "delegated_users", "users", column: "current_user"
  add_foreign_key "delegated_users", "users", column: "delegated_user"
  add_foreign_key "event_participants", "users", column: "participant"
  add_foreign_key "events", "event_statuses"
  add_foreign_key "events", "event_types"
  add_foreign_key "events", "users", column: "creador"
  add_foreign_key "main_posts", "posts"
  add_foreign_key "members", "bands"
  add_foreign_key "members", "knowledges", column: "instrument_id"
  add_foreign_key "members", "musicians"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users", column: "autor"
  add_foreign_key "musician_knowledges", "knowledges"
  add_foreign_key "musician_knowledges", "levels"
  add_foreign_key "musician_knowledges", "musicians"
  add_foreign_key "posts", "users"
  add_foreign_key "sala_genres", "genres"
  add_foreign_key "sala_genres", "salas"
  add_foreign_key "sala_reviews", "salas"
  add_foreign_key "sala_reviews", "users"
  add_foreign_key "sala_users", "salas"
  add_foreign_key "sala_users", "users"
  add_foreign_key "salas", "users", column: "creator_id"
  add_foreign_key "users", "roles"
end
