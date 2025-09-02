# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Session details operations", type: :feature do
  describe "the operations possible on the page" do
    let!(:student_user) { create(:user, role: "student") }
    let!(:student_user_2) { create(:user, role: "student") }
    let!(:admin_user) { create(:user, role: "admin") }
    let!(:teacher_user) { create(:user, role: "teacher") }
    let!(:school_year) { create(:school_year) }
    let!(:grade_level) { create(:grade_level, school_year: school_year) }
    let!(:school_term) { create(:school_term) }
    let!(:grade_level_student_user) { create(:grade_level_student_user, grade_level:, user: student_user) }
    let!(:subject) { create(:subject, grade_level:) }

    context "when there are no signed in user" do
      it "redirects to root path" do
        visit session_details_path
        expect(page).to have_content("You need to sign in or sign up before continuing")
      end
    end

    context "when the current user is a student" do
      before do
        sign_in student_user
        visit show_profile_path(id: student_user.id)
        click_on school_year.title
      end
      it "shows the student progress in the selected session year" do
        expect(page).to have_content("Below is the progress achieved in the #{school_year.title} academic session by #{student_user.full_name}")
      end

      it "does not show the link to create or change an exam score" do
          expect(page).not_to have_button("Change")
          expect(page).not_to have_button("Create")
      end

      it "shows the subjects in the current grade level" do
        expect(page).to have_content("First Term")
        expect(page).to have_content("Second Term")
        expect(page).to have_content(subject.title)
      end
    end

    context "when the current user is an admin/student" do
      before do
        @current_user = [ admin_user, teacher_user ].sample
        sign_in @current_user
        visit show_profile_path(id: student_user.id)
        click_on school_year.title
      end

      it "shows the link to create or change an exam score" do
          expect(page).not_to have_button("Change")
          expect(page).not_to have_button("Create")
      end

      it "shows the subjects in the current grade level" do
        expect(page).to have_content("First Term")
        expect(page).to have_content("Second Term")
        expect(page).to have_content(subject.title)
      end

      context "when the admin/teacher wants to create or change a score for an exam" do
        context "when the user clicks on the create button, then goes back to update the score" do
          it "allows the user to perform creation and update operations" do
            # Creation starts
            first(:link, "examination_for_subject_id_#{subject.id}_first_test").click
            expect(page).to have_content("Enter Examination Score")

            fill_in "examination_score",	with: "20"
            click_on "Save"

            expect(page).to have_content("Exam score for created successfully")
            expect(page).to have_content("20")
            expect(page).to have_content(student_user.full_name)
            expect(page).to have_content(@current_user.full_name)

            # Creation ends/Update Starts

            visit show_profile_path(id: student_user.id)
            click_on school_year.title
            first(:link, "examination_id_#{Examination.first.id}_subject_id_#{subject.id}_first_test").click
            fill_in "examination_score",	with: "10"
            click_on "Update"

            expect(page).to have_content("Exam score for updated successfully")
            expect(page).to have_content("10")
            expect(page).to have_content(student_user.full_name)
          end
        end
      end
    end
  end
end
