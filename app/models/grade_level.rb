# frozen_string_literal: true

class GradeLevel < ApplicationRecord
  belongs_to :school_year
  has_many :yearly_grade_levels, dependent: :destroy
  has_many :users, through: :yearly_grade_levels
  has_many :departments, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :school_year_id }

  scope :sorted_by_session, -> { includes(:school_year).order("school_years.title ASC") }
  JUNIOR_GRADES = [ "JSS 1", "JSS 2", "JSS 3" ]
  SENIOR_GRADES = [ "SSS 1", "SSS 2", "SSS 3" ]
  GRADE_TITLES = [ *JUNIOR_GRADES, *SENIOR_GRADES ]
end
