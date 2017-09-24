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

ActiveRecord::Schema.define(version: 20170924154529) do

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

# Could not dump table "customers" because of following StandardError
#   Unknown type 'real' for column 'rental_charge'

  create_table "reservations", force: :cascade do |t|
    t.string "customer_id"
    t.string "car_id"
    t.datetime "from_time"
    t.datetime "to_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
