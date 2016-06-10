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

ActiveRecord::Schema.define(version: 20160610182636) do

  create_table "bands", force: :cascade do |t|
    t.integer  "genre1_id",  limit: 4, null: false
    t.integer  "genre2_id",  limit: 4
    t.integer  "genre3_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "bands", ["genre1_id"], name: "index_bands_on_genre1_id", using: :btree
  add_index "bands", ["genre2_id"], name: "index_bands_on_genre2_id", using: :btree
  add_index "bands", ["genre3_id"], name: "index_bands_on_genre3_id", using: :btree

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

  create_table "musicians", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "nombre", limit: 255, null: false
  end

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

  add_foreign_key "bands", "genres", column: "genre1_id"
  add_foreign_key "bands", "genres", column: "genre2_id"
  add_foreign_key "bands", "genres", column: "genre3_id"
  add_foreign_key "members", "bands"
  add_foreign_key "members", "knowledges", column: "instrument_id"
  add_foreign_key "members", "musicians"
  add_foreign_key "musician_knowledges", "knowledges"
  add_foreign_key "musician_knowledges", "levels"
  add_foreign_key "musician_knowledges", "musicians"
  add_foreign_key "users", "roles"
end
