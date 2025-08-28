# frozen_string_literal: true

class SubjectsSubscriptionService
  JUNIOR_SUBJECTS = [ "Mathematics", "English", "Literature-in-English", "Basic Science", "Basic Technology", "Physical and Health Education", "Religious Studies", "French", "Yoruba", "Music Appreciation", "Agricultural Science", "Phonics", "Civic Education", "Home Economics", "Business Studies", "Computer Studies", "History" ]
  SENIOR_SUBJECTS = [ "Agricultural Science", "Biology", "Chemistry", "Civic Education", "Commerce", "Economics", "English", "Financial Accounts", "Further Mathematics", "Geography", "Government", "Literature-in-English", "Mathematics", "Phonics", "Physics", "Religious Studies", "Yoruba" ]

  def initialize(grade_level)
    @grade_level = grade_level
  end

  def call
    JUNIOR_SUBJECTS.each do |junior_subject|
      puts "IAM HEEERS"
      @grade_level.subjects.where(title: junior_subject).first_or_create!
    end if GradeLevel::JUNIOR_GRADES.include?(@grade_level[:title])

    SENIOR_SUBJECTS.each do |senior_subject|
      @grade_level.subjects.where(title: senior_subject).first_or_create!
    end if GradeLevel::SENIOR_GRADES.include?(@grade_level[:title])
  end
end
