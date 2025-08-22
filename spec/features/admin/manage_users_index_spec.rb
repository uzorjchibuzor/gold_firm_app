require "rails_helper"

RSpec.describe "Manage Users Page", type: :feature do
  context "only a signed in user who is an admin can view this page" do
    let!(:student_user) { create(:user, role: "student") }
    let!(:teacher_user) { create(:user, role: "teacher") }
    let!(:admin_user) { create(:user, role: "admin") }


    scenario "When user not signed in" do
      visit admin_manage_users_path
      expect(page).to have_content("You must be an admin to access the requested page")
    end

    scenario "When signed in user is a student" do
      sign_in student_user

      visit admin_manage_users_path
      expect(page).to have_content("You must be an admin to access the requested page")
    end

    scenario "When signed in user is a teacher" do
      sign_in teacher_user

      visit admin_manage_users_path
      expect(page).to have_content("You must be an admin to access the requested page")
    end

    scenario "When signed in user is an admin, the registered users are listed with a link to edit to edit the profile/go to the user show page" do
      sign_in admin_user

      visit admin_manage_users_path

      expect(page).to have_content("You may click on the user you want to manage from the table below")
      expect(page).to have_link(student_user.full_name)
    end
    context "when the admin clicks on the edit button" do
      before do
        sign_in admin_user
        visit admin_manage_users_path
      end


      it "goes to a page to edit the user profile" do
        click_on student_user.full_name
        expect(page).to have_content("Complete the form below to enroll this user for the current session")
      end
    end
  end
end
