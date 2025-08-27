class GradeLevel < ApplicationRecord
  belongs_to :school_year
  has_many :yearly_grade_levels, dependent: :destroy
  has_many :users, through: :yearly_grade_levels

  validates :title, presence: true, uniqueness: { scope: :school_year_id }

  GRADE_TITLES = [ "JSS 1", "JSS 2", "JSS 3", "SSS 1", "SSS 2", "SSS 3" ]
end
