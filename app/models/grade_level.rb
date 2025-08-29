# frozen_string_literal: true

class GradeLevel < ApplicationRecord
  belongs_to :school_year
  has_many :school_terms, dependent: :destroy
  has_many :grade_level_student_users, dependent: :destroy
  has_many :users, through: :grade_level_student_users
  has_many :departments, dependent: :destroy
  has_many :grade_level_school_terms, dependent: :destroy
  has_many :school_terms, through: :grade_level_school_terms
  has_many :subjects, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :school_year_id }

  # default_scope { includes(:school_year).order("school_years.title DESC") }
  JUNIOR_GRADES = [ "JSS 1", "JSS 2", "JSS 3" ]
  SENIOR_GRADES = [ "SSS 1", "SSS 2", "SSS 3" ]
  GRADE_TITLES = [ *JUNIOR_GRADES, *SENIOR_GRADES ]

  after_save do |grade_level|
    SchoolTermsCreationService.new(grade_level).call
  end
end
