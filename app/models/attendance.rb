class Attendance < ApplicationRecord
  belongs_to :grade_level
  belongs_to :user
  
  validates :date, presence: true
  validates :status, presence: true

  enum :status, {absent: 0, excused: 1, present: 2}
end
