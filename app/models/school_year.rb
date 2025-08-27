class SchoolYear < ApplicationRecord
  before_save :set_clean_year_title

  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments
  has_many :school_terms, dependent: :destroy
  has_many :grade_levels, dependent: :destroy

  validates :start_year, presence: true
  validates :end_year, presence: true
  validates :start_year, uniqueness: { scope: :end_year }
  validate :start_year_must_be_one_less_than_end_year

  default_scope { order(start_year: :desc) }

  # Ex:- scope :active, -> {where(:active => true)}

  after_save do |school_year|
    SchoolTerm::TERM_TITLES.each do |term_title|
      school_year.school_terms.create(term_title: term_title)
    end
  end

  private

  def start_year_must_be_one_less_than_end_year
    unless start_year.to_i + 1 === end_year.to_i
      errors.add(:start_year, "Must be one less than End Year")
    end
  end

  def set_clean_year_title
    self.title = "#{self.start_year}/#{self.end_year}"
  end
end
