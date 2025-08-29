class CreateGradeLevelStudentUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :grade_level_student_users do |t|
      t.references :grade_level, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
