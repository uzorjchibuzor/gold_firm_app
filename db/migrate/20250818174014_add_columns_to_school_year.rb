# frozen_string_literal: true

class AddColumnsToSchoolYear < ActiveRecord::Migration[7.2]
  def change
    add_column :school_years, :start_year, :string, default: Date.today.year.to_s
    add_column :school_years, :end_year, :string, default: (Date.today.year + 1).to_s
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
