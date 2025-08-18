class CreateSchoolYears < ActiveRecord::Migration[7.2]
  def change
    create_table :school_years do |t|
      t.timestamps
    end
  end
end
