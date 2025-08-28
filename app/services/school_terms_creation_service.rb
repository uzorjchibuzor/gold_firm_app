class SchoolTermsCreationService
  def initialize(school_year)
    @school_year = school_year
  end

  def call
    SchoolTerm::TERM_TITLES.each do |term_title|
      @school_year.school_terms.create(term_title: term_title)
    end
  end
end
