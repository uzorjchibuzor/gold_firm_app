# frozen_string_literal: true

class GradeLevel < ApplicationRecord
  belongs_to :school_year

  has_many :attendances, dependent: :destroy
  has_many :examinations, dependent: :destroy
  has_many :grade_level_school_terms, dependent: :destroy
  has_many :grade_level_student_users, dependent: :destroy
  has_many :grade_level_school_terms, dependent: :destroy
  has_many :school_terms, through: :grade_level_school_terms
  has_many :subjects, dependent: :destroy
  has_many :users, through: :grade_level_student_users

  validates :title, presence: true, uniqueness: { scope: :school_year_id }

  # default_scope { includes(:school_year).order("school_years.title DESC") }
  JUNIOR_GRADES = [ "JSS 1", "JSS 2", "JSS 3" ]
  SENIOR_GRADES = [ "SSS 1 ARTS", "SSS 1 COMMERCIAL", "SSS 1 SCIENCES", "SSS 2 ARTS", "SSS 2 COMMERCIAL", "SSS 2 SCIENCES", "SSS 3 ARTS", "SSS 3 COMMERCIAL", "SSS 3 SCIENCES" ]
  GRADE_TITLES = [ *JUNIOR_GRADES, *SENIOR_GRADES ]

  after_save do |grade_level|
    SchoolTermsCreationService.new(grade_level).call
  end
end
