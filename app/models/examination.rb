# frozen_string_literal: true

class Examination < ApplicationRecord
  belongs_to :user
  belongs_to :grade_level
  belongs_to :subject
  belongs_to :school_term

  enum :exam_type, { first_test: 0, second_test: 1, term_exam: 2 }

  validate :score_within_limits

  validates :subject, uniqueness: { scope: [ :subject_id, :grade_level_id, :school_term_id, :exam_type ] }

  default_scope { order(exam_type: :asc) }

  private

  def score_within_limits
    if [ "first_test", "second_test" ].include?(exam_type) && score > 20
      errors.add(:score, "(Assessments) must be less than or equal to 20")
    elsif exam_type == "term_exam" && score > 60
      errors.add(:score, "(Term exam) must be less than or equal to 60")
    end
  end
end
