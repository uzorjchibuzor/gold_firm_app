require 'rails_helper'

RSpec.describe SchoolTermsCreationService do
  describe "#call" do
    context "when a school year object is created" do
      let!(:school_year) { create(:school_year) }
      it "creates the three associated school terms object" do
        service = SchoolTermsCreationService.new(school_year)
        expect { service.call }.to change(school_year.school_terms, :count).by(3)
      end
    end
  end
end
