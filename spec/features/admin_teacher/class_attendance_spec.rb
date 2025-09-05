# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Attendance Taking Operations", type: :feature do
  describe "the operations possible for this feature" do
    let!(:student_user) { create(:user, role: "student") }
    let!(:student_user_2) { create(:user, role: "student") }
    let!(:admin_user) { create(:user, role: "admin") }
    let!(:teacher_user) { create(:user, role: "teacher") }
    let!(:school_year) { create(:school_year) }
    let!(:grade_level) { create(:grade_level, school_year: school_year) }
    let!(:grade_level_2) { create(:grade_level, title: "SSS 2 COMMERCIAL", school_year: school_year) }
    let!(:school_term) { create(:school_term) }
    let!(:grade_level_student_user) { create(:grade_level_student_user, grade_level:, user: student_user) }
    let!(:grade_level_student_user_2) { create(:grade_level_student_user, grade_level: grade_level_2, user: student_user_2) }
    let!(:subject) { create(:subject, grade_level:) }

    context "only an admin or a teacher can see this page" do
      it "returns alerts the user with the reason for the redirect" do
      sign_in student_user
      visit attendances_path
      expect(page).to have_content("You must be an admin or teacher to access the requested page")
      end
    end

    context "when the user is an admin or teacher" do
      before do
        @current_user = [ admin_user, teacher_user ].sample
        sign_in @current_user
      end

      it "shows the page, with a table for the list of all students assignment for the current week" do
        visit attendances_path
        expect(page).to have_content(student_user.full_name)
        expect(page).to have_content(student_user_2.full_name)
        expect(page).to have_content(student_user.grade_levels.first.title)
        expect(page).to have_content("SSS 2 COMMERCIAL")
      end


      describe "attendance object creation" do
        context "when the admin/teacher goes to their profile page, then clicks on a take attendance link" do
          before do
            visit show_profile_path(@current_user)
          end
          it "displays the classes with buttons to create take attendance for that class" do
            expect(page).to have_link("take_attendance_button_class_id_#{grade_level.id}")
          end
          context "when the TAKE ATTENDANCE button is clicked" do
            it "sends the user to a page with the students in the selected grade_level" do
              click_on "take_attendance_button_class_id_#{grade_level.id}"

              expect(page).not_to have_content(student_user.full_name)
              expect(page).not_to have_content(grade_level.title)
            end
          end
          context "when the user selects the attendance option for the chosen date from the dropdown and submits" do
            it "goes back to the index page for all attendances after creating the attendance object for the selected users " do
              click_on "take_attendance_button_class_id_#{grade_level.id}"
              fill_in "attendance_date", with: "2025-08-08"
              select "Absent", from: "attendance_student_id_#{student_user.id}_status"
              click_on "Submit Attendance"

              expect(page).to have_content("Attendance for 2025-08-08 was successfully recorded.")
              expect(page).to have_css("#student_#{student_user.id}_2025-08-08", text: "Absent")
            end
          end
        end
      end
    end
  end
end
