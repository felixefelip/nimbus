# == Schema Information
#
# Table name: quiz_realizations
#
#  id                          :bigint           not null, primary key
#  finished_at                 :datetime
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  teacher_quiz_realization_id :bigint           not null
#  user_id                     :bigint           not null
#
class QuizRealization < ApplicationRecord
  belongs_to :user
  belongs_to :teacher_quiz_realization

  has_one :quiz, through: :teacher_quiz_realization

  has_many :quiz_realization_answers, dependent: :destroy
  has_many :questions, through: :quiz

  def score
    correct_answers_count = quiz_realization_answers.count(&:correct?)
    questions_total_count = questions.count

    (correct_answers_count * 10) / questions_total_count
  end

  def next_question
    quiz.questions[quiz_realization_answers.count]
  end

  def find_realization_answer_by_question(question)
    quiz_realization_answers.find_by(question:)
  end
end
