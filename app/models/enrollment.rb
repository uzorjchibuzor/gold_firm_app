class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :school_year
end
