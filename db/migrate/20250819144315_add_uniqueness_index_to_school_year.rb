# frozen_string_literal: true

class AddUniquenessIndexToSchoolYear < ActiveRecord::Migration[7.2]
  def change
    add_index :school_years, [ :start_year, :end_year ], unique: true
  end
end
