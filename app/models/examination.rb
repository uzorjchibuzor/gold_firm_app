# frozen_string_literal: true

class Examination < ApplicationRecord
  attr_accessor :updater_id

  belongs_to :user
  belongs_to :grade_level
  belongs_to :subject
  belongs_to :school_term
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  has_many :examination_histories, dependent: :destroy

  enum :exam_type, { first_test: 0, second_test: 1, term_exam: 2 }

  validate :score_within_limits

  validates :creator_id, presence: true
  validates :exam_type, presence: true
  validates :subject, uniqueness: { scope: [ :subject_id, :grade_level_id, :school_term_id, :exam_type ] }

  default_scope { order(exam_type: :asc) }

    def creator
      User.find_by(id: creator_id)
    end

  before_update :log_history

  private

  def log_history
    return if new_record?
    examination_histories.create(user: User.find(updater_id),
    changes_made: self.changes.to_json
    )
  end

  def score_within_limits
    if [ "first_test", "second_test" ].include?(exam_type) && score > 20
      errors.add(:score, "(Assessments) must be less than or equal to 20")
    elsif exam_type == "term_exam" && score > 60
      errors.add(:score, "(Term exam) must be less than or equal to 60")
    end
  end
end
