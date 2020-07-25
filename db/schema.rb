# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_24_155548) do

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "item_name", null: false
    t.text "item_image", null: false
    t.string "seller", null: false
    t.string "category", null: false
    t.string "brand", null: false
    t.string "size", null: false
    t.string "condition", null: false
    t.string "postage_player", null: false
    t.string "postage_type", null: false
    t.integer "prefecture_code", null: false
    t.string "shipping_date", null: false
    t.integer "price", null: false
    t.text "introduction", null: false
    t.string "buyer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "prefecture_code_id"
    t.bigint "prefecture_id", null: false
    t.index ["prefecture_code_id"], name: "index_items_on_prefecture_code_id"
    t.index ["prefecture_id"], name: "index_items_on_prefecture_id"
  end

  create_table "prefectures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "items", "prefectures"
end
