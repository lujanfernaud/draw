require 'rails_helper'

RSpec.describe RandomPhotosController, vcr: VCR_OPTIONS, type: :controller do
  describe "GET #show" do
    it "responds with an HTTP 302 status code" do
      create_request

      get :show, params: { request_id: "animal" }

      expect(response).to have_http_status(302)
    end

    it "redirects to 'photos/show" do
      create_request

      photo = single_photo_from_request

      get :show, params: { request_id: "animal" }

      expect(response).to redirect_to request_photo_path("animal", photo.id)
    end

    it "redirects to root url if the query is not allowed" do
      create_request

      get :show, params: { request_id: "sprite" }

      expect(response).to redirect_to(root_url)
    end
  end

  private

    def create_request
      Request.create!(name: "animal", query: "animal")
    end

    def single_photo_from_request
      photo_double   = Photo.create
      request_double = double("request")

      allow(Request).to receive(:find_by).and_return(request_double)

      allow(request_double).to receive(:updated_today?).and_return(true)
      allow(request_double).to receive(:name).and_return("animal")
      allow(request_double).to receive(:photos).and_return([photo_double])

      allow(photo_double).to receive(:id).and_return(1)

      photo_double
    end
end
