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

ActiveRecord::Schema.define(version: 20160806125626) do

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

  create_table "flight_crews", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flights", force: :cascade do |t|
    t.integer  "fleet_id"
    t.time     "takeoff_time"
    t.time     "landing_time"
    t.float    "flight_time"
    t.date     "departure_date"
    t.time     "departure_time"
    t.time     "arrival_time"
    t.float    "block_time"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "origin"
    t.string   "destination"
    t.index ["fleet_id"], name: "index_flights_on_fleet_id", using: :btree
  end

  create_table "incoming_details", force: :cascade do |t|
    t.integer  "incoming_movement_id"
    t.integer  "product_id"
    t.float    "quantity"
    t.date     "expiration_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["incoming_movement_id"], name: "index_incoming_details_on_incoming_movement_id", using: :btree
    t.index ["product_id"], name: "index_incoming_details_on_product_id", using: :btree
  end

  create_table "incoming_movement_types", force: :cascade do |t|
    t.string   "movement_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "incoming_movements", force: :cascade do |t|
    t.integer  "incoming_movement_type_id"
    t.integer  "supplier_id"
    t.string   "folio"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["incoming_movement_type_id"], name: "index_incoming_movements_on_incoming_movement_type_id", using: :btree
    t.index ["supplier_id"], name: "index_incoming_movements_on_supplier_id", using: :btree
  end

  create_table "inspections", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outgoing_details", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "outgoing_movement_id"
    t.float    "quantity"
    t.date     "expiration_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["outgoing_movement_id"], name: "index_outgoing_details_on_outgoing_movement_id", using: :btree
    t.index ["product_id"], name: "index_outgoing_details_on_product_id", using: :btree
  end

  create_table "outgoing_movement_types", force: :cascade do |t|
    t.string   "movement_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "outgoing_movements", force: :cascade do |t|
    t.integer  "outgoing_movement_type_id"
    t.integer  "receiver_id"
    t.string   "folio"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["outgoing_movement_type_id"], name: "index_outgoing_movements_on_outgoing_movement_type_id", using: :btree
    t.index ["receiver_id"], name: "index_outgoing_movements_on_receiver_id", using: :btree
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

  create_table "passengers", force: :cascade do |t|
    t.integer  "flight_id"
    t.string   "name"
    t.string   "identification_number"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["flight_id"], name: "index_passengers_on_flight_id", using: :btree
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

  create_table "product_quantities", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "description"
    t.float    "quantity"
    t.date     "expiration_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["product_id"], name: "index_product_quantities_on_product_id", using: :btree
  end

  create_table "product_units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "procurement_lead_time"
    t.string   "part_number"
    t.string   "description"
    t.text     "specification"
    t.integer  "maximum"
    t.integer  "minimum"
    t.integer  "optimum"
    t.boolean  "obsolete",              default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "product_unit_id"
    t.index ["product_unit_id"], name: "index_products_on_product_unit_id", using: :btree
  end

  create_table "receivers", force: :cascade do |t|
    t.string   "receiver"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "flight_crew_id"
    t.integer  "flight_id"
    t.string   "role"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["flight_crew_id"], name: "index_roles_on_flight_crew_id", using: :btree
    t.index ["flight_id"], name: "index_roles_on_flight_id", using: :btree
  end

  create_table "scheduled_inspections", force: :cascade do |t|
    t.integer  "system_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["system_id"], name: "index_scheduled_inspections_on_system_id", using: :btree
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "supplier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "tools", force: :cascade do |t|
    t.string   "part_number"
    t.string   "description"
    t.text     "specification"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "actions", "scheduled_inspections"
  add_foreign_key "components", "systems"
  add_foreign_key "fleets", "aircrafts"
  add_foreign_key "flights", "fleets"
  add_foreign_key "incoming_details", "incoming_movements"
  add_foreign_key "incoming_details", "products"
  add_foreign_key "incoming_movements", "incoming_movement_types"
  add_foreign_key "incoming_movements", "suppliers"
  add_foreign_key "outgoing_details", "outgoing_movements"
  add_foreign_key "outgoing_details", "products"
  add_foreign_key "outgoing_movements", "outgoing_movement_types"
  add_foreign_key "outgoing_movements", "receivers"
  add_foreign_key "over_the_time_limits", "time_limits"
  add_foreign_key "over_the_time_limits", "units"
  add_foreign_key "parts", "components"
  add_foreign_key "passengers", "flights"
  add_foreign_key "priorities", "inspections"
  add_foreign_key "priorities", "scheduled_inspections"
  add_foreign_key "procedures", "actions"
  add_foreign_key "procedures", "tasks"
  add_foreign_key "product_quantities", "products"
  add_foreign_key "products", "product_units"
  add_foreign_key "roles", "flight_crews"
  add_foreign_key "roles", "flights"
  add_foreign_key "scheduled_inspections", "systems"
  add_foreign_key "systems", "aircrafts"
  add_foreign_key "tasks", "systems"
  add_foreign_key "time_limits", "actions"
  add_foreign_key "time_limits", "inspections"
  add_foreign_key "time_limits", "units"
end
