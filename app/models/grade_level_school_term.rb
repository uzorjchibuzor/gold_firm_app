# frozen_string_literal: true

class GradeLevelSchoolTerm < ApplicationRecord
  belongs_to :grade_level
  belongs_to :school_term
end
