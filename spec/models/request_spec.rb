require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:request) { Request.create!(query: "animal") }

  describe "validations", :vcr do
    subject { Request.create!(query: "animal") }
    it { should validate_uniqueness_of(:query) }
  end

  describe "#photo" do
    before do
      @unsplash_photo_object = /Unsplash::Photo:\d\w[\d|\w]{14}/
    end

    it "returns photo object", :vcr do
      expect(request.photo.to_s).to match(@unsplash_photo_object)
    end

    it "always returns random photo from category", :vcr do
      photos = []
      28.times { photos << request.photo }
      expect(photos.uniq.count).to eq(photos.count)
    end
  end

  describe "#updated_today?" do
    it "returns true if updated today", :vcr do
      expect(request.updated_today?).to eq(true)
    end
  end
end
