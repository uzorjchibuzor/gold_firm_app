class ExaminationHistory < ApplicationRecord
  belongs_to :examination
  belongs_to :user
end
