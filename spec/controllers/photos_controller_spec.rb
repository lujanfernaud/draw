require 'rails_helper'

RSpec.describe PhotosController, vcr: VCR_OPTIONS, type: :controller do
  let(:create_request) { Request.create!(name: "animal", query: "animal") }

  describe "GET #index" do
    before do
      create_request
    end

    it "responds successfully with an HTTP 200 status code" do
      get :index, params: { request_id: "animal" }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the 'index' template" do
      get :index, params: { request_id: "animal" }
      expect(response).to render_template("index")
    end

    it "redirects to root url if the query is not allowed" do
      get :index, params: { request_id: "sprite" }
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET #show" do
    before do
      create_request
      @photo = Request.find_by(name: "animal").photos.first
    end

    it "responds successfully with an HTTP 200 status code" do
      get :show, params: { request_id: "animal", id: @photo.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the 'show' template" do
      get :show, params: { request_id: "animal", id: @photo.id }
      expect(response).to render_template("show")
    end
  end
end
