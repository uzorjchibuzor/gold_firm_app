# frozen_string_literal: true

class ChangeSchoolYearReferenceToGradeLevelInSchoolTerms < ActiveRecord::Migration[7.2]
  def change
    remove_reference :school_terms, :school_year, foreign_key: true

    add_reference :school_terms, :grade_level, foreign_key: true
  end
end
