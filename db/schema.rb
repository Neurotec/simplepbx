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

ActiveRecord::Schema.define(version: 20170531195335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "callcenter_queue_profiles", force: :cascade do |t|
    t.string   "type"
    t.string   "name",                          default: "General"
    t.string   "moh_sound",                     default: "$${hold_music}"
    t.string   "time_base_score",               default: "queue"
    t.boolean  "tier_rules_apply",              default: false
    t.integer  "tier_rule_wait_second",         default: 300
    t.boolean  "tier_rule_wait_multiply_level", default: true
    t.boolean  "tier_rule_no_agent_no_wait",    default: false
    t.integer  "discard_abandoned_after",       default: 14400
    t.boolean  "abandoned_resume_allowed",      default: false
    t.integer  "max_wait_time",                 default: 0
    t.integer  "max_wait_time_with_no_agent",   default: 120
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "callcenter_queues", force: :cascade do |t|
    t.string   "name"
    t.string   "uuid"
    t.integer  "freeswitch_id"
    t.string   "strategy"
    t.integer  "callcenter_queue_profile_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["callcenter_queue_profile_id"], name: "index_callcenter_queues_on_callcenter_queue_profile_id", using: :btree
    t.index ["freeswitch_id"], name: "index_callcenter_queues_on_freeswitch_id", using: :btree
  end

  create_table "callcenter_tiers", force: :cascade do |t|
    t.integer  "extension_id"
    t.integer  "callcenter_queue_id"
    t.integer  "level",               default: 1
    t.integer  "position",            default: 1
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["callcenter_queue_id"], name: "index_callcenter_tiers_on_callcenter_queue_id", using: :btree
    t.index ["extension_id"], name: "index_callcenter_tiers_on_extension_id", using: :btree
  end

  create_table "cdrs", force: :cascade do |t|
    t.integer  "freeswitch_id"
    t.string   "call_uuid"
    t.string   "caller_id_name"
    t.string   "caller_id_number"
    t.string   "destination_number"
    t.string   "record_path"
    t.integer  "start_epoch"
    t.integer  "duration"
    t.integer  "hangup_cause_q850"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "hangup_cause"
    t.index ["freeswitch_id"], name: "index_cdrs_on_freeswitch_id", using: :btree
  end

  create_table "destination_profile_actions", force: :cascade do |t|
    t.integer  "destination_profile_id"
    t.string   "application"
    t.string   "data"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["destination_profile_id"], name: "index_destination_profile_actions_on_destination_profile_id", using: :btree
  end

  create_table "destination_profiles", force: :cascade do |t|
    t.integer  "endpoint_id"
    t.string   "type"
    t.string   "name"
    t.string   "uuid"
    t.string   "condition_field"
    t.string   "condition_expression"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["endpoint_id"], name: "index_destination_profiles_on_endpoint_id", using: :btree
  end

  create_table "endpoint_outbound_routes", force: :cascade do |t|
    t.integer  "outbound_route_id"
    t.integer  "endpoint_route_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["endpoint_route_id"], name: "index_endpoint_outbound_routes_on_endpoint_route_id", using: :btree
    t.index ["outbound_route_id"], name: "index_endpoint_outbound_routes_on_outbound_route_id", using: :btree
  end

  create_table "endpoint_routes", force: :cascade do |t|
    t.integer  "endpoint_id"
    t.string   "destination_number"
    t.integer  "inbound_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "uuid"
    t.integer  "position",           default: 0
  end

  create_table "endpoints", force: :cascade do |t|
    t.integer  "freeswitch_id"
    t.string   "uuid"
    t.string   "address"
    t.integer  "port"
    t.string   "external_address"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "domain"
    t.index ["freeswitch_id"], name: "index_endpoints_on_freeswitch_id", using: :btree
  end

  create_table "extension_groups", force: :cascade do |t|
    t.integer  "extension_id"
    t.integer  "group_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["extension_id"], name: "index_extension_groups_on_extension_id", using: :btree
    t.index ["group_id"], name: "index_extension_groups_on_group_id", using: :btree
  end

  create_table "extension_profile_actions", force: :cascade do |t|
    t.integer  "extension_profile_id"
    t.integer  "priority",             default: 0
    t.string   "application"
    t.string   "data"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["extension_profile_id"], name: "index_extension_profile_actions_on_extension_profile_id", using: :btree
  end

  create_table "extension_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_extension_profiles_on_user_id", using: :btree
  end

  create_table "extensions", force: :cascade do |t|
    t.integer  "endpoint_id"
    t.string   "username"
    t.string   "password"
    t.integer  "vmpassword"
    t.string   "cid_name",             default: ""
    t.string   "cid_number",           default: ""
    t.string   "location"
    t.integer  "extension_profile_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "do_record",            default: false
    t.index ["endpoint_id"], name: "index_extensions_on_endpoint_id", using: :btree
    t.index ["extension_profile_id"], name: "index_extensions_on_extension_profile_id", using: :btree
  end

  create_table "freeswitches", force: :cascade do |t|
    t.string   "host"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "user_id"
    t.integer  "event_socket_port",     default: 8021
    t.string   "event_socket_password", default: "ClueCon"
    t.string   "name"
    t.string   "xml_rpc_realm",         default: "freeswitch"
    t.string   "xml_rpc_user",          default: "freeswitch"
    t.string   "xml_rpc_pass",          default: "works"
    t.integer  "xml_rpc_port",          default: 8080
    t.string   "record_public_user",    default: "simplepbx_recording"
    t.index ["user_id"], name: "index_freeswitches_on_user_id", using: :btree
  end

  create_table "group_permissions", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "allow_create"
    t.boolean  "allow_read"
    t.boolean  "allow_update"
    t.boolean  "allow_delete"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer  "endpoint_id"
    t.string   "name"
    t.string   "uuid"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["endpoint_id"], name: "index_groups_on_endpoint_id", using: :btree
  end

  create_table "inbounds", force: :cascade do |t|
    t.integer  "endpoint_id"
    t.string   "name"
    t.string   "uuid"
    t.string   "host"
    t.string   "username"
    t.string   "password"
    t.boolean  "register"
    t.string   "cid_name",    default: "$${outbound_caller_id_name}"
    t.string   "cid_number",  default: "$${outbound_caller_id_number}"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.index ["endpoint_id"], name: "index_inbounds_on_endpoint_id", using: :btree
  end

  create_table "ivr_actions", force: :cascade do |t|
    t.integer  "ivr_menu_id"
    t.integer  "outbound_route_id"
    t.integer  "digits"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["ivr_menu_id"], name: "index_ivr_actions_on_ivr_menu_id", using: :btree
    t.index ["outbound_route_id"], name: "index_ivr_actions_on_outbound_route_id", using: :btree
  end

  create_table "ivr_menus", force: :cascade do |t|
    t.integer  "greet_long_id"
    t.integer  "greet_short_id"
    t.integer  "invalid_sound_id"
    t.integer  "exit_sound_id"
    t.integer  "timeout",             default: 10000
    t.integer  "inter_digit_timeout", default: 2000
    t.integer  "max_failures",        default: 3
    t.integer  "digit_len",           default: 4
    t.integer  "menu_top_digits",     default: 9
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "freeswitch_id"
    t.string   "uuid"
    t.string   "name"
    t.index ["freeswitch_id"], name: "index_ivr_menus_on_freeswitch_id", using: :btree
  end

  create_table "outbound_routes", force: :cascade do |t|
    t.string   "foreign_class_name"
    t.integer  "foreign_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "freeswitch_id"
    t.index ["foreign_id"], name: "index_outbound_routes_on_foreign_id", using: :btree
  end

  create_table "outbounds", force: :cascade do |t|
    t.integer  "endpoint_id"
    t.string   "name"
    t.string   "uuid"
    t.string   "realm"
    t.string   "username"
    t.string   "password"
    t.boolean  "register"
    t.boolean  "cidfrom"
    t.string   "codecs"
    t.string   "proxy"
    t.string   "cid_name"
    t.string   "cid_number"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["endpoint_id"], name: "index_outbounds_on_endpoint_id", using: :btree
  end

  create_table "resource_objects", force: :cascade do |t|
    t.string   "foreign_class_name"
    t.integer  "foreign_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "freeswitch_id"
  end

  create_table "resource_records", force: :cascade do |t|
    t.integer  "freeswitch_id"
    t.string   "name"
    t.string   "path"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["freeswitch_id"], name: "index_resource_records_on_freeswitch_id", using: :btree
  end

  create_table "user_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "group_permissions_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["group_permissions_id"], name: "index_user_groups_on_group_permissions_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "callcenter_queues", "callcenter_queue_profiles"
  add_foreign_key "callcenter_queues", "freeswitches"
  add_foreign_key "callcenter_tiers", "callcenter_queues"
  add_foreign_key "callcenter_tiers", "extensions"
  add_foreign_key "cdrs", "freeswitches"
  add_foreign_key "destination_profile_actions", "destination_profiles"
  add_foreign_key "destination_profiles", "endpoints"
  add_foreign_key "endpoint_outbound_routes", "endpoint_routes"
  add_foreign_key "endpoint_outbound_routes", "outbound_routes"
  add_foreign_key "endpoints", "freeswitches"
  add_foreign_key "extension_groups", "extensions"
  add_foreign_key "extension_groups", "groups"
  add_foreign_key "extension_profile_actions", "extension_profiles"
  add_foreign_key "extension_profiles", "users"
  add_foreign_key "extensions", "endpoints"
  add_foreign_key "extensions", "extension_profiles"
  add_foreign_key "freeswitches", "users"
  add_foreign_key "groups", "endpoints"
  add_foreign_key "inbounds", "endpoints"
  add_foreign_key "ivr_actions", "ivr_menus"
  add_foreign_key "ivr_actions", "outbound_routes"
  add_foreign_key "ivr_menus", "freeswitches"
  add_foreign_key "outbounds", "endpoints"
  add_foreign_key "resource_records", "freeswitches"
  add_foreign_key "user_groups", "group_permissions", column: "group_permissions_id"
end
