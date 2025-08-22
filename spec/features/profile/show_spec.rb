require "rails_helper"

RSpec.describe "User Profile Show page", type: :feature do
  describe "The operations available on the profile show page" do
    let!(:student_user) { create(:user, role: "student") }
    let!(:student_user_2) { create(:user, role: "student") }
    let!(:admin_user) { create(:user, role: "admin") }
    let!(:school_year) { create(:school_year) }
    let!(:enrollment) { create(:enrollment, user: student_user, school_year:) }
    let!(:enrollment_2) { create(:enrollment, user: student_user_2, school_year:) }

    context "when the user is not an admin" do
      before do
          sign_in student_user
        end
      it "shows the sessions the user is enrolled for in a table" do
        visit show_profile_path(id: student_user.id)

        expect(page).to have_content("#{student_user.full_name}'s enrollment history")
        expect(page).to have_content("#{enrollment.school_year.start_year}/#{enrollment.school_year.end_year}")
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
        expect(page).to have_content("#{enrollment.school_year.start_year}/#{enrollment.school_year.end_year}")

        visit show_profile_path(id: student_user_2.id)

        expect(page).to have_content("#{student_user_2.full_name}'s enrollment history")
      end

      it "allows the admin to unenroll a user" do
        visit show_profile_path(id: student_user.id)

        expect(page).to have_button("Unenroll #{student_user.full_name}")

        click_on "#{student_user.full_name}"

        expect(page).to have_content("#{student_user.full_name} has been successfully unenrolled")
        expect(student_user.enrollment.find_by(id: enrollment.id)).not_to be present?
      end
    end
  end
end
