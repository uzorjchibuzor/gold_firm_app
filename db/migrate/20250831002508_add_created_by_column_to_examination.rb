# frozen_string_literal: true

class AddCreatedByColumnToExamination < ActiveRecord::Migration[7.2]
  def change
    add_column :examinations, :created_by, :string, null: false, default: ""
  end
end
