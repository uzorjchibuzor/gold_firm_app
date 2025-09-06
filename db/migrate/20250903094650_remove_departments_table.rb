# frozen_string_literal: true

class RemoveDepartmentsTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :departments
  end
end
