class Department < ApplicationRecord
  belongs_to :grade_level

  ALLOWED_TITLES = [ "Junior", "Sciences", "Commercial", "Arts" ].freeze

  validates :title, uniqueness: { scope: :grade_level_id }
  validate :allowed_department_titles


  private

  def allowed_department_titles
    unless ALLOWED_TITLES.include?(title)
      errors.add(:title, "This title is not allowed for a department, please choose from the dropdown options")
    end
  end
end
