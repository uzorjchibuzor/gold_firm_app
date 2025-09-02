# frozen_string_literal: true

FactoryBot.define do
  factory :examination_history do
    examination { nil }
    updater { nil }
  end

  factory :examination do
    user
    grade_level
    subject
    school_term
    exam_type { "term_exam" }
    score { 57 }
    creator { user }
  end

  factory :department do
    grade_level
    title { "General" }
  end

  factory :grade_level do
    title { "JSS 1" }
    school_year
  end

  factory :grade_level_school_term do
    grade_level
    school_term
  end

  factory :grade_level_student_user do
    grade_level
    user
  end

  factory :school_term do
    title { "First Term" }
  end

  factory :school_year do
    start_year { 1.years.ago.year }
    end_year { 0.years.ago.year }
  end

  factory :subject do
    grade_level
    title { "Mathematics" }
  end

  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }
    role { "student" }
    disabled { false }
  end
end
