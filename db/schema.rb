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

ActiveRecord::Schema.define(version: 20140817162545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "code_lessons", force: true do |t|
    t.string   "name"
    t.text     "lesson_content",   default: ""
    t.text     "instructions",     default: ""
    t.text     "hints",            default: ""
    t.text     "starting_code"
    t.integer  "language_id"
    t.integer  "order"
    t.integer  "track_id"
    t.integer  "user_id"
    t.boolean  "visible",          default: false
    t.boolean  "shareable",        default: false
    t.integer  "organisation_id"
    t.datetime "date_due"
    t.text     "correctness_test"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "name",            default: ""
    t.text     "description",     default: ""
    t.integer  "organisation_id"
    t.string   "colour",          default: "#4589E3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: true do |t|
    t.string   "name"
    t.string   "ace_slug"
    t.string   "code_eval_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisations", force: true do |t|
    t.integer  "ref"
    t.string   "name"
    t.string   "email"
    t.text     "description"
    t.string   "url"
    t.string   "location"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_users"
  end

  add_index "organisations", ["ref"], name: "index_organisations_on_ref", unique: true, using: :btree
  add_index "organisations", ["student_id"], name: "index_organisations_on_student_id", using: :btree

  create_table "students", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.integer  "organisation_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true, using: :btree
  add_index "students", ["organisation_id"], name: "index_students_on_organisation_id", using: :btree
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true, using: :btree
  add_index "students", ["username", "organisation_id"], name: "index_students_on_username_and_organisation_id", unique: true, using: :btree

  create_table "teachers", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title",                  default: ""
    t.integer  "organisation_id"
  end

  add_index "teachers", ["email"], name: "index_teachers_on_email", unique: true, using: :btree
  add_index "teachers", ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true, using: :btree

  create_table "tracks", force: true do |t|
    t.string   "name"
    t.text     "description", default: ""
    t.integer  "course_id"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.integer  "organisation_id"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "teacher",                default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username", "organisation_id"], name: "index_users_on_username_and_organisation_id", unique: true, using: :btree

end
