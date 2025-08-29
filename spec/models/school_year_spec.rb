require 'rails_helper'

RSpec.describe SchoolYear, type: :model do
  describe "school year object creation by the SchoolYear model" do
    context "when supplied with valid attributes" do
      let!(:school_year) { create(:school_year, start_year: "2025", end_year: "2026") }

      it "persists the school_year object in the database" do
        expect(school_year.save!).to be true
        expect(SchoolYear.count).to eq(1)
      end
    end

    context "when supplied with invalid attributes" do
      let!(:school_year) { build(:school_year, start_year: "2026", end_year: "2025") }

      it "does not persist the object in the database" do
        expect { school_year.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
