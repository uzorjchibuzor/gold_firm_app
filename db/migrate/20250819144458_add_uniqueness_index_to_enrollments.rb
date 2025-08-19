class AddUniquenessIndexToEnrollments < ActiveRecord::Migration[7.2]
  def change
    add_index :enrollments, [ :user_id, :school_year_id ], unique: true
  end
end
