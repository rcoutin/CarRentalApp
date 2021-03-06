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

ActiveRecord::Schema.define(version: 20171004073653) do

  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.string "password_digest"
    t.boolean "is_super_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_approvals", force: :cascade do |t|
    t.string "manufacturer"
    t.string "model"
    t.string "license_number"
    t.string "status"
    t.decimal "rate"
    t.string "style"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "manufacturer"
    t.string "model"
    t.string "license_number"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "rate"
    t.string "style"
    t.string "location"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.date "date_of_birth"
    t.string "license_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.float "rental_charge", default: 0.0
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_histories", force: :cascade do |t|
    t.integer "reservation_id"
    t.integer "customer_id"
    t.integer "car_id"
    t.datetime "from_time"
    t.datetime "to_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total_charges", precision: 30, scale: 2
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "car_id"
    t.datetime "from_time"
    t.datetime "to_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total_charges", precision: 30, scale: 2
    t.index ["car_id"], name: "index_reservations_on_car_id", unique: true
    t.index ["customer_id"], name: "index_reservations_on_customer_id", unique: true
  end

end
