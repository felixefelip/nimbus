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

ActiveRecord::Schema[7.0].define(version: 2023_06_19_045829) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "questions", force: :cascade do |t|
    t.string "description"
    t.integer "difficulty"
    t.bigint "quiz_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "alternative1"
    t.string "alternative2"
    t.string "alternative3"
    t.string "alternative4"
    t.integer "correct_answer", null: false
    t.string "image"
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quiz_availabilities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "quiz_id", null: false
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_availabilities_on_quiz_id"
    t.index ["user_id"], name: "index_quiz_availabilities_on_user_id"
  end

  create_table "quiz_realization_answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "quiz_realization_id", null: false
    t.integer "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_quiz_realization_answers_on_question_id"
    t.index ["quiz_realization_id"], name: "index_quiz_realization_answers_on_quiz_realization_id"
  end

  create_table "quiz_realizations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "finished_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "quiz_availability_id", null: false
    t.index ["quiz_availability_id"], name: "index_quiz_realizations_on_quiz_availability_id"
    t.index ["user_id"], name: "index_quiz_realizations_on_user_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "last_name"
    t.integer "access_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "questions", "quizzes"
  add_foreign_key "quiz_availabilities", "quizzes"
  add_foreign_key "quiz_availabilities", "users"
  add_foreign_key "quiz_realization_answers", "questions"
  add_foreign_key "quiz_realization_answers", "quiz_realizations"
  add_foreign_key "quiz_realizations", "quiz_availabilities"
  add_foreign_key "quiz_realizations", "users"
end
