require 'rails_helper'

RSpec.describe "Admin::SchoolYears", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/admin/school_years/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/admin/school_years/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/school_years/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/admin/school_years/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/admin/school_years/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/admin/school_years/update"
      expect(response).to have_http_status(:success)
    end
  end

end
