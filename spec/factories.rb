# frozen_string_literal: true

FactoryBot.define do
  factory :grade_level do
    title { "MyString" }
  end

  factory :yearly_grade_level do
    user { nil }
    grade_level { nil }
    user { nil }
  end

  factory :school_term do
    term_title { "MyString" }
    school_year { nil }
  end

  factory :term do
    school_year
    term_title { [ "First Term", "Second Term", "Third Term" ] }
  end


  factory :school_year do
    start_year { Date.today.year }
    end_year { Date.today.year + 1 }
  end

  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }
    role { "student" }
    current_class { "JSS 1" }
  end

  factory :enrollment do
    user
    school_year
  end
end
