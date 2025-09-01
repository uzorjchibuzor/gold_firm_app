# frozen_string_literal: true

class AddTitleColumnToSchoolYear < ActiveRecord::Migration[7.2]
  def change
    add_column :school_years, :title, :string
  end
end
