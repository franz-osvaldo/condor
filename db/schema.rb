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

ActiveRecord::Schema.define(version: 20160717063312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aircrafts", force: :cascade do |t|
    t.string   "manufacturer"
    t.string   "trade_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "components", force: :cascade do |t|
    t.integer  "system_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["system_id"], name: "index_components_on_system_id", using: :btree
  end

  create_table "fleets", force: :cascade do |t|
    t.integer  "aircraft_id"
    t.string   "name"
    t.string   "aircraft_registration"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["aircraft_id"], name: "index_fleets_on_aircraft_id", using: :btree
  end

  create_table "parts", force: :cascade do |t|
    t.integer  "component_id"
    t.string   "description"
    t.string   "part_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["component_id"], name: "index_parts_on_component_id", using: :btree
  end

  create_table "systems", force: :cascade do |t|
    t.integer  "aircraft_id"
    t.string   "title"
    t.integer  "chapter_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["aircraft_id"], name: "index_systems_on_aircraft_id", using: :btree
  end

  add_foreign_key "components", "systems"
  add_foreign_key "fleets", "aircrafts"
  add_foreign_key "parts", "components"
  add_foreign_key "systems", "aircrafts"
end
