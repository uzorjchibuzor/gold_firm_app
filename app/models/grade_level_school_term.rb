class GradeLevelSchoolTerm < ApplicationRecord
  belongs_to :grade_level
  belongs_to :school_term
end
