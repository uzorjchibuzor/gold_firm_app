# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attendance, type: :model do
  describe "attendance object creation" do
    let!(:user) { create(:user) }
    let!(:grade_level) { create(:grade_level) }
    let!(:good_attendance) { build(:attendance, user:, grade_level:, date: "2025-09-06") }
    let!(:no_user_attendance) { build(:attendance, user: nil, grade_level:, date: "2025-09-06") }
    let!(:no_grade_attendance) { build(:attendance, user:, grade_level: nil, date: "2025-09-06") }
    let!(:no_date_attendance) { build(:attendance, user:, grade_level:, date: "") }
    context "when supplied with valid attributes" do
      it "persists the object in the dB" do
        expect(good_attendance.valid?).to be true
        expect { good_attendance.save! }.not_to raise_error
      end
    end

    context "when supplied with invalid attributes" do
      it "does not persist the object in the dB" do
        expect(no_user_attendance.valid?).to be false
        expect { no_user_attendance.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(no_date_attendance.valid?).to be false
        expect { no_date_attendance.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(no_grade_attendance.valid?).to be false
        expect { no_grade_attendance.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
