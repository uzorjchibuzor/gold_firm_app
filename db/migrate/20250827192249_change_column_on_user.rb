class ChangeColumnOnUser < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :current_class

    add_column :users, :disabled, :boolean, default: false
  end
end
