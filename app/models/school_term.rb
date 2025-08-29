# frozen_string_literal: true

class SchoolTerm < ApplicationRecord
  has_many :grade_level_school_terms, dependent: :destroy
  has_many :grade_levels, through: :grade_level_school_terms
  has_many :examinations, dependent: :destroy

  TERM_TITLES = [
    "First Term",
    "Second Term",
    "Third Term"
  ]
end
