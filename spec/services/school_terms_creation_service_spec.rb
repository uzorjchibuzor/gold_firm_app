# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchoolTermsCreationService do
  describe "#call" do
    context "when a school year object is created" do
      let!(:grade_level) { create(:grade_level) }
      it "creates the three associated school terms object" do
        service = SchoolTermsCreationService.new(grade_level)
        expect { service.call }.to change(grade_level.school_terms, :count).by(3)
      end
    end
  end
end
