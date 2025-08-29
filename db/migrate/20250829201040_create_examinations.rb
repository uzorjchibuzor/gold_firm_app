# frozen_string_literal: true

class CreateExaminations < ActiveRecord::Migration[7.2]
  def change
    create_table :examinations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :grade_level, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.references :school_term, null: false, foreign_key: true
      t.integer :exam_type, null: false
      t.integer :score, default: 0

      t.timestamps
    end
  end
end
