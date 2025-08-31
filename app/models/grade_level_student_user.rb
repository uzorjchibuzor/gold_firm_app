# frozen_string_literal: true

class GradeLevelStudentUser < ApplicationRecord
  belongs_to :grade_level
  belongs_to :user
end
