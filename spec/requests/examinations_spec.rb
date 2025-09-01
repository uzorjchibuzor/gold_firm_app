require 'rails_helper'

RSpec.describe "Examinations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/examinations/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/examinations/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/examinations/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/examinations/new"
      expect(response).to have_http_status(:success)
    end
  end

end
