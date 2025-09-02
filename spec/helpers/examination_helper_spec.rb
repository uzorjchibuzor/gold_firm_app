# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExaminationHelper, type: :helper do
  describe "all the methods in the helper" do
    let!(:user_2) { create(:user) }
    let!(:user) { create(:user) }
    let!(:grade_level) { create(:grade_level) }
    let!(:subject) { create(:subject, grade_level:) }
    let!(:subject_2) { create(:subject, grade_level:) }
    let!(:school_term) { create(:school_term) }
    let!(:examination) { create(:examination, user:, grade_level:, subject:, school_term:, exam_type: "first_test", score: 19) }
    let!(:examination_2) { create(:examination, user:, grade_level:, subject:, school_term:, exam_type: "second_test", score: 15) }
    let!(:examination_3) { create(:examination, user:, grade_level:, subject:, school_term:, exam_type: "term_exam", score: 48) }
    let!(:exam_term_subject_params) { { examinations: Examination.all, school_term_id: school_term.id, subject_id: subject.id } }
    let!(:bad_exam_term_subject_params) { { examinations: Examination.where(user_id: user_2.id), term_id: school_term.id, subject_id: subject_2.id } }
    describe "#action_button_for_examination" do
      context "when the examination object exists" do
        it "displays a Change Button" do
          change_button = helper.action_button_for_examination("first_test", exam_term_subject_params)
          expect(change_button).to include("Change")
          expect(change_button).to include("examination_id_#{examination.id}_subject_id_#{subject.id}")
        end
      end

      context "when the examination object does not exist" do
        it "displays a Create Button" do
          change_button = helper.action_button_for_examination("first_test", bad_exam_term_subject_params)
          expect(change_button).to include("Create")
          expect(change_button).to include("examination_for_subject_id_#{subject_2.id}")
        end
      end
    end
    
    describe "#assign_letter_grade" do
      it "returns corresponding letter grade for a variety of scores from 0 to 100" do
        expect(helper.assign_letter_grade(39)).to eq("F9")
        expect(helper.assign_letter_grade(40)).to eq("E8")
        expect(helper.assign_letter_grade(49)).to eq("D7")
        expect(helper.assign_letter_grade(54)).to eq("C6")
        expect(helper.assign_letter_grade(58)).to eq("C5")
        expect(helper.assign_letter_grade(63)).to eq("C4")
        expect(helper.assign_letter_grade(69)).to eq("B3")
        expect(helper.assign_letter_grade(73)).to eq("B2")
        expect(helper.assign_letter_grade(80)).to eq("A1")
      end
    end

    describe "#find_score_by_type" do
      it "returns the score obtained by a student in an subject examination type" do
        expect(helper.find_score_by_type("first_test", exam_term_subject_params)).to eq(19)
        expect(helper.find_score_by_type("term_exam", exam_term_subject_params)).to eq(48)
      end

      it "returns a NOT FOUND string if the exam object is not found" do
        expect(helper.find_score_by_type("first_test", bad_exam_term_subject_params)).to eq("Not Found")
      end
    end

    describe "subject_percentage_score" do
      it "returns a hash with percentage score and equivalent letter grade" do
        expect(helper.subject_percentage_score(exam_term_subject_params)).to eq({ total_score: 82, letter_grade: "A1" })
      end
    end
  end
end
