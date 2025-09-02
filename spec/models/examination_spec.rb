# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Examination, type: :model do
  describe "model object creation by Examination model" do
    context "with valid attributes" do
      let!(:user) { create(:user) }
      let!(:admin_user) { create(:user, role: "admin") }
      let!(:grade_level) { create(:grade_level) }
      let!(:subject) { create(:subject, grade_level:) }
      let!(:school_term) { create(:school_term) }
      let!(:examination) { build(:examination, user:, grade_level:, subject:, school_term:, exam_type: "first_test", score: 19) }

      it "persists the object in the dB" do
        examination.updater_id = admin_user.id
        expect { examination.save! }.to change(Examination, :count).by 1
        expect(examination.save!).to be true
      end
    end

    context "with invalid attributes" do
      let!(:user) { create(:user) }
      let!(:grade_level) { create(:grade_level) }
      let!(:subject) { create(:subject, grade_level:) }
      let!(:school_term) { create(:school_term) }
      let!(:examination) { build(:examination, user: nil, grade_level:, subject:, school_term:, exam_type: "first_test", score: 19) }
      let!(:examination_2) { build(:examination, user:, grade_level:, subject:, school_term:, exam_type: "first_test", score: 21) }
      let!(:examination_3) { build(:examination, user:, grade_level:, subject:, school_term:, exam_type: "term_exam", score: 61) }
      context "when any of the model it belongs to is not present" do
        it "does not persist the object in the dB" do
          expect { examination.save! }.to raise_error ActiveRecord::RecordInvalid
        end
      end

      context "when score for exams of types of /first_test or second_test/ is greater than 20" do
        it "does not persist the object in the dB" do
          expect { examination_2.save! }.to raise_error ActiveRecord::RecordInvalid
        end
      end

      context "when score for exams of types of /term_exam/ is greater than 60" do
        it "does not persist the object in the dB" do
          expect { examination_3.save! }.to raise_error ActiveRecord::RecordInvalid
        end
      end
    end
  end
end
