# frozen_string_literal: true

class CreateGradeLevelSchoolTerms < ActiveRecord::Migration[7.2]
  def change
    create_table :grade_level_school_terms do |t|
      t.references :grade_level, null: false, foreign_key: true
      t.references :school_term, null: false, foreign_key: true

      t.timestamps
    end
  end
end
