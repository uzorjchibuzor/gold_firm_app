# frozen_string_literal: true

class ExaminationHistory < ApplicationRecord
  belongs_to :examination
  belongs_to :user

  default_scope { order(created_at: :desc) }
end
