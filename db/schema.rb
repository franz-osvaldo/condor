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

ActiveRecord::Schema.define(version: 20160720055130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.integer  "scheduled_inspection_id"
    t.text     "action"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["scheduled_inspection_id"], name: "index_actions_on_scheduled_inspection_id", using: :btree
  end

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

  create_table "inspections", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "over_the_time_limits", force: :cascade do |t|
    t.integer  "time_limit_id"
    t.integer  "unit_id"
    t.float    "time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["time_limit_id"], name: "index_over_the_time_limits_on_time_limit_id", using: :btree
    t.index ["unit_id"], name: "index_over_the_time_limits_on_unit_id", using: :btree
  end

  create_table "parts", force: :cascade do |t|
    t.integer  "component_id"
    t.string   "description"
    t.string   "part_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["component_id"], name: "index_parts_on_component_id", using: :btree
  end

  create_table "priorities", force: :cascade do |t|
    t.integer  "scheduled_inspection_id"
    t.integer  "inspection_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["inspection_id"], name: "index_priorities_on_inspection_id", using: :btree
    t.index ["scheduled_inspection_id"], name: "index_priorities_on_scheduled_inspection_id", using: :btree
  end

  create_table "procedures", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "action_id"
    t.string   "procedure"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_id"], name: "index_procedures_on_action_id", using: :btree
    t.index ["task_id"], name: "index_procedures_on_task_id", using: :btree
  end

  create_table "scheduled_inspections", force: :cascade do |t|
    t.integer  "system_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["system_id"], name: "index_scheduled_inspections_on_system_id", using: :btree
  end

  create_table "systems", force: :cascade do |t|
    t.integer  "aircraft_id"
    t.string   "title"
    t.integer  "chapter_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["aircraft_id"], name: "index_systems_on_aircraft_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "system_id"
    t.string   "name"
    t.string   "task_number"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["system_id"], name: "index_tasks_on_system_id", using: :btree
  end

  create_table "time_limits", force: :cascade do |t|
    t.integer  "action_id"
    t.integer  "unit_id"
    t.integer  "inspection_id"
    t.float    "time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["action_id"], name: "index_time_limits_on_action_id", using: :btree
    t.index ["inspection_id"], name: "index_time_limits_on_inspection_id", using: :btree
    t.index ["unit_id"], name: "index_time_limits_on_unit_id", using: :btree
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "actions", "scheduled_inspections"
  add_foreign_key "components", "systems"
  add_foreign_key "fleets", "aircrafts"
  add_foreign_key "over_the_time_limits", "time_limits"
  add_foreign_key "over_the_time_limits", "units"
  add_foreign_key "parts", "components"
  add_foreign_key "priorities", "inspections"
  add_foreign_key "priorities", "scheduled_inspections"
  add_foreign_key "procedures", "actions"
  add_foreign_key "procedures", "tasks"
  add_foreign_key "scheduled_inspections", "systems"
  add_foreign_key "systems", "aircrafts"
  add_foreign_key "tasks", "systems"
  add_foreign_key "time_limits", "actions"
  add_foreign_key "time_limits", "inspections"
  add_foreign_key "time_limits", "units"
end
