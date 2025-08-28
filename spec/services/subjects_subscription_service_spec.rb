require 'rails_helper'

RSpec.describe SubjectsSubscriptionService do
  describe "#call" do
    context "when a user is enrolled for a grade in a particular school year" do
      let!(:grade_level) { create(:grade_level, title: "JSS 3") }
      context "when the enrolled grade is in Junior Secondary" do
        it "checks if the grade subjects are available, creates them if they aren't" do
          service = SubjectsSubscriptionService.new(grade_level)
          expect { service.call }.to change(Subject, :count).by(SubjectsSubscriptionService::JUNIOR_SUBJECTS.count)
        end
      end

      context "when the enrolled grade is in Junior Secondary" do
        let!(:grade_level) { create(:grade_level, title: "SSS 3") }
        it "checks if the grade subjects are available, creates them if they aren't" do
          service = SubjectsSubscriptionService.new(grade_level)
          expect { service.call }.to change(Subject, :count).by(SubjectsSubscriptionService::JUNIOR_SUBJECTS.count)
        end
      end
    end
  end
end
