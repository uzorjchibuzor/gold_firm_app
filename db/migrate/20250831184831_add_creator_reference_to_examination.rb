# frozen_string_literal: true

class AddCreatorReferenceToExamination < ActiveRecord::Migration[7.2]
  def change
    add_reference :examinations, :creator, null: false, foreign_key: { to_table: :users }
  end
end
