require 'rails_helper'

RSpec.describe Request, :vcr, type: :model do
  let(:request) { Request.create!(query: "face") }

  describe "validations" do
    subject { Request.create!(query: "face") }
    it { should validate_uniqueness_of(:query) }
  end

  describe "#photos" do
    it "returns an array of photos" do
      expect(request.photos.size).not_to be(0)
    end
  end

  describe "#updated_today?" do
    it "returns true if updated today" do
      expect(request.updated_today?).to eq(true)
    end
  end
end
