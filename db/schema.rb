# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_12_17_031824) do
  create_table "opportunities", force: :cascade do |t|
    t.string "noticeId", null: false
    t.string "title"
    t.string "solicitationNumber"
    t.datetime "postedDate"
    t.string "opportunity_type"
    t.string "naicsCode"
    t.string "classificationCode"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classificationCode"], name: "index_opportunities_on_classificationCode"
    t.index ["naicsCode"], name: "index_opportunities_on_naicsCode"
    t.index ["noticeId"], name: "index_opportunities_on_noticeId", unique: true
    t.index ["postedDate"], name: "index_opportunities_on_postedDate"
  end
end
