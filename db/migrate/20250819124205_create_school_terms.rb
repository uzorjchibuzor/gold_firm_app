class CreateSchoolTerms < ActiveRecord::Migration[7.2]
  def change
    create_table :school_terms do |t|
      t.string :term_title, null: false
      t.references :school_year, null: false, foreign_key: true

      t.timestamps
    end
  end
end
