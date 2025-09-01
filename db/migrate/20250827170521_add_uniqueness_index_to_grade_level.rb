# frozen_string_literal: true

class AddUniquenessIndexToGradeLevel < ActiveRecord::Migration[7.2]
  def change
    add_index :grade_levels, [ :title, :school_year_id ], unique: true
  end
end
