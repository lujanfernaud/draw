require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the 'index' template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code", :vcr do
      get :show, params: { id: "animal" }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the 'show' template", :vcr do
      get :show, params: { id: "animal" }
      expect(response).to render_template("show")
    end

    it "redirects to root url if the reference is not allowed" do
      get :show, params: { id: "astro" }
      expect(response).to redirect_to(root_url)
    end
  end
end
