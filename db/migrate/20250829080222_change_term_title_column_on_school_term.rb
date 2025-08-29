# frozen_string_literal: true

class ChangeTermTitleColumnOnSchoolTerm < ActiveRecord::Migration[7.2]
  def change
    rename_column :school_terms, :term_title, :title
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
