require 'rails_helper'

RSpec.describe RequestsHelper, vcr: VCR_OPTIONS, type: :helper do
  describe "#random_photo_for" do
    before do
      @query_name   = "animal"
      @test_request = Request.create!(name: @query_name, query: @query_name)
      @request_photos_ids = @test_request.photos.map(&:id)
    end

    it "returns a random photo id from request's photos" do
      expect(random_photo_for(@query_name)).to be_in(@request_photos_ids)
    end
  end
end
