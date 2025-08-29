# frozen_string_literal: true

class SchoolTermsCreationService
  def initialize(grade_level)
    @grade_level = grade_level
  end

  def call
    SchoolTerm::TERM_TITLES.each do |title|
      @grade_level.school_terms.create!(title: title)
    end
  end
end
