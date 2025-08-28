# frozen_string_literal: true

class SchoolTerm < ApplicationRecord
  belongs_to :school_year

  TERM_TITLES = [
    "First Term",
    "Second Term",
    "Third Term"
  ]
end
