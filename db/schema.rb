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

ActiveRecord::Schema[7.2].define(version: 2025_09_03_094650) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "examination_histories", force: :cascade do |t|
    t.bigint "examination_id", null: false
    t.bigint "user_id", null: false
    t.text "changes_made", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["examination_id"], name: "index_examination_histories_on_examination_id"
    t.index ["user_id"], name: "index_examination_histories_on_user_id"
  end

  create_table "examinations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "grade_level_id", null: false
    t.bigint "subject_id", null: false
    t.bigint "school_term_id", null: false
    t.integer "exam_type", null: false
    t.integer "score", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id", null: false
    t.index ["creator_id"], name: "index_examinations_on_creator_id"
    t.index ["grade_level_id"], name: "index_examinations_on_grade_level_id"
    t.index ["school_term_id"], name: "index_examinations_on_school_term_id"
    t.index ["subject_id"], name: "index_examinations_on_subject_id"
    t.index ["user_id"], name: "index_examinations_on_user_id"
  end

  create_table "grade_level_school_terms", force: :cascade do |t|
    t.bigint "grade_level_id", null: false
    t.bigint "school_term_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_level_id"], name: "index_grade_level_school_terms_on_grade_level_id"
    t.index ["school_term_id"], name: "index_grade_level_school_terms_on_school_term_id"
  end

  create_table "grade_level_student_users", force: :cascade do |t|
    t.bigint "grade_level_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_level_id"], name: "index_grade_level_student_users_on_grade_level_id"
    t.index ["user_id"], name: "index_grade_level_student_users_on_user_id"
  end

  create_table "grade_levels", force: :cascade do |t|
    t.string "title"
    t.bigint "school_year_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_year_id"], name: "index_grade_levels_on_school_year_id"
    t.index ["title", "school_year_id"], name: "index_grade_levels_on_title_and_school_year_id", unique: true
  end

  create_table "school_terms", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "grade_level_id"
    t.index ["grade_level_id"], name: "index_school_terms_on_grade_level_id"
  end

  create_table "school_years", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "start_year", default: "2025"
    t.string "end_year", default: "2026"
    t.string "title"
    t.index ["start_year", "end_year"], name: "index_school_years_on_start_year_and_end_year", unique: true
  end

  create_table "subjects", force: :cascade do |t|
    t.bigint "grade_level_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_level_id"], name: "index_subjects_on_grade_level_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.string "full_name", default: ""
    t.boolean "disabled", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "examination_histories", "examinations"
  add_foreign_key "examination_histories", "users"
  add_foreign_key "examinations", "grade_levels"
  add_foreign_key "examinations", "school_terms"
  add_foreign_key "examinations", "subjects"
  add_foreign_key "examinations", "users"
  add_foreign_key "examinations", "users", column: "creator_id"
  add_foreign_key "grade_level_school_terms", "grade_levels"
  add_foreign_key "grade_level_school_terms", "school_terms"
  add_foreign_key "grade_level_student_users", "grade_levels"
  add_foreign_key "grade_level_student_users", "users"
  add_foreign_key "grade_levels", "school_years"
  add_foreign_key "school_terms", "grade_levels"
  add_foreign_key "subjects", "grade_levels"
end
