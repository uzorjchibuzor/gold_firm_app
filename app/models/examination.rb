# frozen_string_literal: true

class Examination < ApplicationRecord
  belongs_to :user
  belongs_to :grade_level
  belongs_to :subject
  belongs_to :school_term
  belongs_to :creator, class_name: "User", foreign_key: :creator_id

  enum :exam_type, { first_test: 0, second_test: 1, term_exam: 2 }

  validate :score_within_limits

  validates :creator_id, presence: true
  validates :subject, uniqueness: { scope: [ :subject_id, :grade_level_id, :school_term_id, :exam_type ] }

  default_scope { order(exam_type: :asc) }

    def creator
      User.find_by(id: creator_id)
    end

  private

  def score_within_limits
    if [ "first_test", "second_test" ].include?(exam_type) && score > 20
      errors.add(:score, "(Assessments) must be less than or equal to 20")
    elsif exam_type == "term_exam" && score > 60
      errors.add(:score, "(Term exam) must be less than or equal to 60")
    end
  end
end
