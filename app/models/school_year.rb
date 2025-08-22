class SchoolYear < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollment
  has_many :school_terms, dependent: :destroy

  validates :start_year, presence: true
  validates :end_year, presence: true
  validates :start_year, uniqueness: { scope: :end_year }
  validate :start_year_must_be_one_less_than_end_year

  default_scope { order(created_at: :desc) }

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
end
