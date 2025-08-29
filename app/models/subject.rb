# frozen_string_literal: true

class Subject < ApplicationRecord
  belongs_to :grade_level

  default_scope { order(title: :asc) }
end
