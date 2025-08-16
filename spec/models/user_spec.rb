require 'rails_helper'

RSpec.describe User, type: :model do
  describe "user object creation by the User model" do
    context "with valid attributes" do
      let!(:user) { build(:user, full_name: Faker::Name.name, email: Faker::Internet.email, password: "123456", password_confirmation: "123456") }

      it "creates a valid user object into the database" do
        expect(user.save).to be true
        expect(User.count).to eq(1)
      end
    end

    context "with invalid attributes" do
      context "with no email address" do
        let!(:user) { build(:user, full_name: Faker::Name.name, email: "", password: "123456", password_confirmation: "123456") }

        it "does not persist the user object into the database" do
          expect { user.save! }.to raise_error ActiveRecord::RecordInvalid
          expect(User.count).to eq(0)
        end
      end

      context "with no Name" do
        let!(:user) { build(:user, full_name: "", email: Faker::Internet.email, password: "123456", password_confirmation: "123456") }

        it "does not persist the user object into the database" do
          expect { user.save! }.to raise_error ActiveRecord::RecordInvalid
          expect(User.count).to eq(0)
        end
      end

      context "with password different password confirmation" do
        let!(:user) { build(:user, full_name: Faker::Name.name, email: Faker::Internet.email, password: "123456", password_confirmation: "1234567") }

        it "does not persist the user object into the database" do
          expect { user.save! }.to raise_error ActiveRecord::RecordInvalid
          expect(User.count).to eq(0)
        end
      end
    end
  end
end
