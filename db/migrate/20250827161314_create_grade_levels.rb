# frozen_string_literal: true

class CreateGradeLevels < ActiveRecord::Migration[7.2]
  def change
    create_table :grade_levels do |t|
      t.string :title

      t.references :school_year, null: false, foreign_key: true
      t.timestamps
    end
  end
end
