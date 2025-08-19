class SchoolYear < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollment
  has_many :school_terms

  validates :start_year, uniqueness: { scope: :end_year }

  default_scope { order(created_at: :desc) }

  # Ex:- scope :active, -> {where(:active => true)}

  after_save do |school_year|
    SchoolTerm::TERM_TITLES.each do |term_title|
      school_year.school_terms.create(term_title: term_title)
    end
  end
end
