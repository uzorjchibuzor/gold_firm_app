require 'rails_helper'

RSpec.describe "Enrollments", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/enrollments/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/enrollments/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /unenroll" do
    it "returns http success" do
      get "/enrollments/unenroll"
      expect(response).to have_http_status(:success)
    end
  end

end
