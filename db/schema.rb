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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20170923144420) do

  create_table "cars", force: :cascade do |t|
    t.string "lpn"
    t.string "manufactuere"
    t.string "model"
    t.decimal "hrr"
    t.string "style"
    t.string "location"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "img_attach"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "email"
    t.string "lpn"
    t.datetime "expect_start_time"
    t.datetime "checkout_time"
    t.datetime "expect_return_time"
    t.datetime "return_time"
    t.string "status"
    t.decimal "charge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
=======
ActiveRecord::Schema.define(version: 20170922004638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
>>>>>>> aed09a94719b8e97cb47522d141385d07c335326

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "authority"
    t.decimal "rental_charge"
  end

end
