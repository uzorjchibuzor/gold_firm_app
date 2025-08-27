class AddSchoolYearIdToYearlyGradeLevels < ActiveRecord::Migration[7.2]
  def change
    add_reference :yearly_grade_levels, :school_year, foreign_key: true, null: false

    add_index :yearly_grade_levels, [ :user_id, :school_year_id ], unique: true
  end
end
