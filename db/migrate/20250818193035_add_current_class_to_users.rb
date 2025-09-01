# frozen_string_literal: true

class AddCurrentClassToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :current_class, :string, default: ""
  end
end
