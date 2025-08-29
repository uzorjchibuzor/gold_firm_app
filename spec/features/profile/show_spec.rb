require "rails_helper"

RSpec.describe "User Profile Show page", type: :feature do
  describe "The operations available on the profile show page" do
    let!(:student_user) { create(:user, role: "student") }
    let!(:student_user_2) { create(:user, role: "student") }
    let!(:admin_user) { create(:user, role: "admin") }
    let!(:school_year) { create(:school_year) }
    let!(:grade_level) { create(:grade_level, school_year: school_year) }
    let!(:school_term) { create(:school_term) }
    let!(:grade_level_student_user) { create(:grade_level_student_user, grade_level:, user: student_user) }

    context "when the user is not an admin" do
      before do
          sign_in student_user
        end
      it "shows the sessions the user is enrolled for in a table" do
        visit show_profile_path(id: student_user.id)

        expect(page).to have_content("#{student_user.full_name}'s enrollment history")
        expect(page).to have_content(school_year.title)
      end

      it "does not allow a user to view another user's page" do
        visit show_profile_path(id: student_user.id)

        expect(page).not_to have_content("#{student_user_2.full_name}'s enrollment history")
        expect(page).to have_content("#{student_user.full_name}'s enrollment history")
      end
    end

    context "when the user is an admin" do
      before do
        sign_in admin_user
      end

      it "shows the whatever student the admin decides to check record for" do
        visit show_profile_path(id: student_user.id)

        expect(page).to have_content("#{student_user.full_name}'s enrollment history")
        expect(page).to have_content(school_year.title)

        visit show_profile_path(id: student_user_2.id)

        expect(page).to have_content("#{student_user_2.full_name}'s enrollment history")
      end

      it "allows the admin to unenroll a user" do
        visit show_profile_path(id: student_user.id)

        expect(page).to have_button("Unenroll #{student_user.full_name}")

        click_on "Unenroll #{student_user.full_name}"

        expect(page).to have_content("#{student_user.full_name} has been successfully unenrolled")
        expect(student_user.grade_level_student_users.find_by(id: grade_level_student_user.id)).not_to be present?
      end

      it "allows the admin to enroll a user for the current school year" do
        grade_level_student_user.destroy

        visit show_profile_path(id: student_user.id)

        expect(page).to have_content("Complete the form below to enroll this user for the current session.")
        expect(page).to have_button("Register")

        select "SSS 3", from: "desired_class"
        select school_year.title, from: "school_session"

        click_on "Register"
        expect(page).to have_content("#{student_user.full_name} has been successfully enrolled")
      end
    end
  end
end
