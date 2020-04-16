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

ActiveRecord::Schema.define(version: 2020_04_13_170741) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "authors", id: false, force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.index ["name"], name: "index_authors_on_name", unique: true
    t.index ["slug"], name: "index_authors_on_slug", unique: true
  end

  create_table "award_winners", force: :cascade do |t|
    t.string "award_id", null: false
    t.integer "year", null: false
    t.string "position", null: false
    t.string "book_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "awards", id: false, force: :cascade do |t|
    t.string "name", null: false
    t.string "category", null: false
    t.string "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "category"], name: "index_awards_on_name_and_category", unique: true
    t.index ["slug"], name: "index_awards_on_slug", unique: true
  end

  create_table "books", id: false, force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.string "author_id", null: false
    t.string "country"
    t.string "language"
    t.date "publication_date"
    t.integer "pages"
    t.string "isbn"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_books_on_slug", unique: true
    t.index ["title", "author_id"], name: "index_books_on_title_and_author_id", unique: true
    t.index ["title"], name: "index_books_on_title"
  end

  add_foreign_key "award_winners", "awards", primary_key: "slug"
  add_foreign_key "award_winners", "books", primary_key: "slug"
  add_foreign_key "books", "authors", primary_key: "slug"
end
