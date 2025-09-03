# frozen_string_literal: true

class SubjectsSubscriptionService
  JUNIOR_SUBJECTS = [ "Mathematics", "English", "Literature-in-English", "Basic Science", "Basic Technology", "Physical and Health Education", "Religious Studies", "French", "Yoruba", "Music Appreciation", "Agricultural Science", "Phonics", "Civic Education", "Home Economics", "Business Studies", "Computer Studies", "History" ]
  GENERAL_SENIOR_SUBJECTS = [ "Agricultural Science", "Biology", "Civic Education", "Economics", "English", "Further Mathematics", "Mathematics", "Phonics", "Yoruba" ]
  SCIENCE_SUBJECTS = [ "Chemistry", "Geography", "Physics" ]
  COMMERCIAL_SUBJECTS = [ "Commerce", "Financial Accounts" ]
  ARTS_SUBJECTS = [ "Government", "Literature-in-English", "Religious Studies" ]

  def initialize(grade_level)
    @grade_level = grade_level
  end

  def call
    JUNIOR_SUBJECTS.each do |junior_subject|
      @grade_level.subjects.where(title: junior_subject).first_or_create!
    end if GradeLevel::JUNIOR_GRADES.include?(@grade_level[:title])

    return unless GradeLevel::SENIOR_GRADES.include?(@grade_level[:title])

    GENERAL_SENIOR_SUBJECTS.each do |senior_subject|
      @grade_level.subjects.where(title: senior_subject).first_or_create!
    end
    if (@grade_level[:title]).include?("ARTS")
      ARTS_SUBJECTS.each do |art_subject|
        @grade_level.subjects.where(title: art_subject).first_or_create!
      end
    elsif (@grade_level[:title]).include?("COMMERCIAL")
      COMMERCIAL_SUBJECTS.each do |commercial_subject|
        @grade_level.subjects.where(title: commercial_subject).first_or_create!
      end
    elsif (@grade_level[:title]).include?("SCIENCES")
      SCIENCE_SUBJECTS.each do |science_subject|
        @grade_level.subjects.where(title: science_subject).first_or_create!
      end
    end
  end
end
