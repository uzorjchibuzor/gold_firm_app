class CreateExaminationHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :examination_histories do |t|
      t.references :examination, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :changes_made, :default => ""

      t.timestamps
    end
  end
end
