# frozen_string_literal: true

class CreateAttendances < ActiveRecord::Migration[7.2]
  def change
    create_table :attendances do |t|
      t.references :user, null: false, foreign_key: true
      t.references :grade_level, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
