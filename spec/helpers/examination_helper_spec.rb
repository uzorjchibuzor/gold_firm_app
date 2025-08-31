require 'rails_helper'

RSpec.describe ExaminationHelper, type: :helper do
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
    let!(:user) { create(:user) }
    let!(:grade_level) { create(:grade_level) }
    let!(:subject) { create(:subject, grade_level:) }
    let!(:school_term) { create(:school_term) }
    let!(:examination) { create(:examination, user:, grade_level:, subject:, school_term:, exam_type: "first_test", score: 19) }
    let!(:examination_2) { create(:examination, user:, grade_level:, subject:, school_term:, exam_type: "term_exam", score: 48) }

    it "returns the score obtained by a student in an subject examination type" do
      expect(helper.find_score_by_type(Examination.all, "first_test", subject, school_term)).to eq(19)
      expect(helper.find_score_by_type(Examination.all, "term_exam", subject, school_term)).to eq(48)
    end
  end

  describe "subject_percentage_score(examinations, subject, term)" do
    let!(:user) { create(:user) }
    let!(:grade_level) { create(:grade_level) }
    let!(:subject) { create(:subject, grade_level:) }
    let!(:school_term) { create(:school_term) }
    let!(:examination) { create(:examination, user:, grade_level:, subject:, school_term:, exam_type: "first_test", score: 19) }
    let!(:examination_3) { create(:examination, user:, grade_level:, subject:, school_term:, exam_type: "term_exam", score: 48) }
    let!(:examination_2) { create(:examination, user:, grade_level:, subject:, school_term:, exam_type: "second_test", score: 15) }

    it "returns a hash with percentage score and equivalent letter grade" do
      examinations = Examination.where(user_id: user.id)
      expect(helper.subject_percentage_score(examinations, subject, school_term)).to eq({ total_score: 82, letter_grade: "A1" })
    end
  end
end
