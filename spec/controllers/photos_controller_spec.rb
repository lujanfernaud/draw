require 'rails_helper'

RSpec.describe PhotosController, :vcr, type: :controller do
  describe "GET #index" do
    before do
      get :index, params: { request_id: "animal" }
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the 'index' template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show", :vcr do
    let(:photo) { Request.find_by(query: "animal").photos.first }

    it "responds successfully with an HTTP 200 status code" do
      get :show, params: { request_id: "animal", id: photo.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the 'show' template" do
      get :show, params: { request_id: "animal", id: photo.id }
      expect(response).to render_template("show")
    end

    it "redirects to root url if the query is not allowed" do
      get :show, params: { request_id: "sprite", id: photo.id }
      expect(response).to redirect_to(root_url)
    end
  end
end
