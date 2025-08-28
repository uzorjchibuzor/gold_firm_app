# frozen_string_literal: true

FactoryBot.define do
  factory :department do
    grade_level
    title { "General" }
  end

  factory :grade_level do
    title { "JSS 1" }
    school_year
  end

  factory :school_term do
    term_title { "First Term" }
    school_year
  end

  factory :school_year do
    start_year { 1.years.ago.year }
    end_year { 0.years.ago.year }
  end

  factory :subject do
    grade_level
    title { "Mathematics" }
  end

  factory :subscribed_subject do
    user
    grade_level
  end

  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }
    role { "student" }
    disabled { false }
  end

  factory :yearly_grade_level do
    user
    grade_level
    school_year
  end
end
