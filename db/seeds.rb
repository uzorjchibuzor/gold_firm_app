# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Starts Transaction"
ActiveRecord::Base.transaction do
  User.create!(email: "cefedigbuej@gmail.com", role: "admin", full_name: "Uzor Lawrence", password: "123456", password_confirmation: "123456")
  User.create!(email: "example@gmail.com", role: "student", full_name: "Lekan Abioye", password: "123456", password_confirmation: "123456")
  User.create!(email: "example@gmail.com", role: "student", full_name: "Badmus Qudus", password: "123456", password_confirmation: "123456")
  User.create!(email: "example_2@gmail.com", role: "student", full_name: "Moriyanu Kolawole", password: "123456", password_confirmation: "123456")
  User.create!(email: "sample@gmail.com", role: "teacher", full_name: "Margaret Shittu", password: "123456", password_confirmation: "123456")
end
p "Ends Transaction"
