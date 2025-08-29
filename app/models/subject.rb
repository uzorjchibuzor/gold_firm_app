# frozen_string_literal: true

class Subject < ApplicationRecord
  belongs_to :grade_level
  has_many :examinations, dependent: :destroy

  default_scope { order(title: :asc) }
end
