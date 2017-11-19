require 'rails_helper'

RSpec.describe Request, vcr: VCR_OPTIONS, type: :model do
  let(:request)     { Request.create!(name: "animal", query: "animal") }
  let(:first_photo) { request.photos.first }
  let(:last_photo)  { request.photos.last }

  describe "validations" do
    it { should validate_uniqueness_of(:query) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:query) }
    it { should validate_presence_of(:name) }
  end

  describe "#next_photo_for" do
    context "when the photo is the first one" do
      it "returns the id of the following photo" do
        expect(request.next_photo_for(first_photo)).to eq(first_photo.id + 1)
      end
    end

    context "when the photo is the last one" do
      it "returns the id of the first photo" do
        expect(request.next_photo_for(last_photo)).to eq(first_photo.id)
      end
    end
  end

  describe "#photos" do
    it "returns an array of photos" do
      expect(request.photos.size).not_to be(0)
    end
  end

  describe "#updated_today?" do
    it "returns true if updated today" do
      updated = request.updated_today?
      expect(request.updated_today?).to eq(updated)
    end
  end
end
