class Attendance < ApplicationRecord
  belongs_to :grade_level
  belongs_to :user
  
  validates :status, presence: true

  validates :date, presence: true, uniqueness: { scope: [:grade_level_id, :user_id] }

  enum :status, {absent: 0, excused: 1, present: 2}
end
