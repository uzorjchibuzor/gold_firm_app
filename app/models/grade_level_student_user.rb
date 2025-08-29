class GradeLevelStudentUser < ApplicationRecord
  belongs_to :grade_level
  belongs_to :user
end
