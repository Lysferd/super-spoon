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

ActiveRecord::Schema.define(version: 2019_08_09_211054) do

  create_table "appointments", force: :cascade do |t|
    t.text "description"
    t.datetime "date"
    t.integer "host_id"
    t.string "visitor_type"
    t.integer "visitor_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_appointments_on_created_by_id"
    t.index ["host_id"], name: "index_appointments_on_host_id"
    t.index ["updated_by_id"], name: "index_appointments_on_updated_by_id"
    t.index ["visitor_type", "visitor_id"], name: "index_appointments_on_visitor_type_and_visitor_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_companies_on_created_by_id"
    t.index ["updated_by_id"], name: "index_companies_on_updated_by_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "cpf"
    t.string "name"
    t.integer "company_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["created_by_id"], name: "index_employees_on_created_by_id"
    t.index ["updated_by_id"], name: "index_employees_on_updated_by_id"
  end

  create_table "facilities", force: :cascade do |t|
    t.string "name"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_facilities_on_created_by_id"
    t.index ["updated_by_id"], name: "index_facilities_on_updated_by_id"
  end

  create_table "residents", force: :cascade do |t|
    t.string "name"
    t.integer "facility_id"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_residents_on_created_by_id"
    t.index ["facility_id"], name: "index_residents_on_facility_id"
    t.index ["updated_by_id"], name: "index_residents_on_updated_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  create_table "visitors", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_visitors_on_created_by_id"
    t.index ["updated_by_id"], name: "index_visitors_on_updated_by_id"
  end

end
