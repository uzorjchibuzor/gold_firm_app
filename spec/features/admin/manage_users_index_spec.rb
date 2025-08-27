require "rails_helper"

RSpec.describe "Manage Users Page", type: :feature do
  context "only a signed in user who is an admin can view this page" do
    let!(:student_user) { create(:user, role: "student") }
    let!(:teacher_user) { create(:user, role: "teacher") }
    let!(:admin_user) { create(:user, role: "admin") }


    context "When user not signed in" do
      it "redirects the user to the home page to login or sign up" do
        visit admin_manage_users_path
        expect(page).to have_content("You need to sign in or sign up before continuing")
      end
    end

    context "When signed in user is a student" do
      it "alerts the user that only an admin is allowed" do
        sign_in student_user

        visit admin_manage_users_path
        expect(page).to have_content("You must be an admin to access the requested page")
      end
    end

    context "When signed in user is a teacher" do
      it "alerts the user that only an admin is allowed" do
        sign_in teacher_user

        visit admin_manage_users_path
        expect(page).to have_content("You must be an admin to access the requested page")
      end
    end

    context "When signed in user is an admin" do
      before do
        sign_in admin_user
        visit admin_manage_users_path
      end
      it "shows the registered users are listed with a link to edit to edit the profile/go to the user show page" do
        expect(page).to have_content("You may click on the user you want to manage from the table below")
        expect(page).to have_link(student_user.full_name)
        expect(page).to have_link("Edit")
        expect(page).to have_link("Create User")
      end

      context "when the admin clicks on the edit button" do
        before do
          click_on "edit_#{student_user.full_name.downcase.sub(" ", "_")}_#{student_user.id}"
        end

        it "goes to a page to edit/update the user profile" do
          expect(page).to have_content("Edit #{student_user.full_name}'s Account")
        end

        context "with invalid attributes" do
          it "does not update, returns to the edit page" do
            fill_in :user_full_name, with: ""
            click_on "Update"

            expect(page).to have_content("Full name can't be blank")
          end
        end

        context "with valid attributes" do
          it "updates the account successfully" do
            fill_in :user_full_name, with: "Rspec Rail"
            click_on "Update"

            expect(page).to have_content("Rspec Rail's account was successfully updated.")
          end
        end
      end

      context "when the admin clicks on the Create User link" do
        before do
          click_on "Create User"
        end

        context "with invalid attributes" do
          it "does not create a new user, returns to form" do
            expect(page).to have_content("Create a new User account")
            fill_in :user_email, with: "alaye@god.com"
            fill_in :user_full_name, with: ""
            select "Student", from: "user_role"
            fill_in :user_password, with: "123456"
            fill_in :user_password_confirmation, with: "123456"

            click_on "Create"

            expect(page).to have_content("Full name can't be blank")
            expect(User.find_by(full_name: "Alaye God").present?).to be false
          end
        end

        context "with valid attributes" do
          it "allows the admin to create a new user" do
            expect(page).to have_content("Create a new User account")
            fill_in :user_email, with: "alaye@god.com"
            fill_in :user_full_name, with: "Alaye God"
            select "Student", from: "user_role"
            fill_in :user_password, with: "123456"
            fill_in :user_password_confirmation, with: "123456"

            click_on "Create"
            expect(page).to have_content("Alaye God's account has been successfully created")
            expect(User.find_by(full_name: "Alaye God").present?).to be true
          end
        end
      end
    end
  end
end
