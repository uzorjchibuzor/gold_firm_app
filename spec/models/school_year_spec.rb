require 'rails_helper'

RSpec.describe SchoolYear, type: :model do
  describe "school year object creation by the SchoolYear model" do
    context "when supplied with valid attributes" do
      let!(:school_year) { create(:school_year, start_year: "2025", end_year: "2026") }

      it "persists the school_year object in the database" do
        expect(school_year.save!).to be true
        expect(SchoolYear.count).to eq(1)
      end
      it "creates associated school_term objects" do
      school_year_id = SchoolYear.find_by(start_year: school_year.start_year, end_year: school_year.end_year).id

        expect(SchoolTerm.count).to eq(3)
        expect(SchoolTerm.find_by(school_year_id: school_year_id, term_title: "First Term")).to be_present
        expect(SchoolTerm.find_by(school_year_id: school_year_id, term_title: "Second Term")).to be_present
        expect(SchoolTerm.find_by(school_year_id: school_year_id, term_title: "Third Term")).not_to be_present
      end

      it "destroys associated school_term objects on upon deletion" do
        school_year_id = SchoolYear.find_by(start_year: school_year.start_year, end_year: school_year.end_year).id
        SchoolYear.find_by(start_year: school_year.start_year, end_year: school_year.end_year).destroy
        expect(SchoolTerm.where(school_year_id: school_year_id).present?).to eq(false)
      end
    end

    context "when supplied with invalid attributes" do
      let!(:school_year) { build(:school_year, start_year: "2026", end_year: "2025") }

      it "does not persist the object in the database" do
        expect { school_year.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "does not create associated school_term objects" do
        expect(SchoolTerm.count).to eq(0)
        expect(SchoolTerm.find_by_term_title("First Term")).not_to be_present
        expect(SchoolTerm.find_by_term_title("Second Term")).not_to be_present
        expect(SchoolTerm.find_by_term_title("Third Term")).to be_present
      end
    end
  end
end
