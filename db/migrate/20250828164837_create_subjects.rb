class CreateSubjects < ActiveRecord::Migration[7.2]
  def change
    create_table :subjects do |t|
      t.references :grade_level, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
