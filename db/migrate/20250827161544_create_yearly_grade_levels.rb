class CreateYearlyGradeLevels < ActiveRecord::Migration[7.2]
  def change
    create_table :yearly_grade_levels do |t|
      t.references :user, null: false, foreign_key: true
      t.references :grade_level, null: false, foreign_key: true

      t.timestamps
    end
  end
end
