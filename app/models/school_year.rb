# frozen_string_literal: true

class SchoolYear < ApplicationRecord
  before_save :set_clean_year_title

  has_many :grade_levels, dependent: :destroy

  validates :start_year, presence: true
  validates :end_year, presence: true
  validates :start_year, uniqueness: { scope: :end_year }
  validate :start_year_must_be_one_less_than_end_year

  default_scope { order(start_year: :desc) }

  private

  def start_year_must_be_one_less_than_end_year
    errors.add(:start_year, "Must be one less than End Year") unless start_year.to_i + 1 === end_year.to_i
  end

  def set_clean_year_title
    self.title = "#{self.start_year}/#{self.end_year}"
  end
end
