class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :school_year

  validates :user_id, uniqueness: { scope: :school_year_id }
end
