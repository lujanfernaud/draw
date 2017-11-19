require 'rails_helper'

RSpec.describe Photo, vcr: VCR_OPTIONS, type: :model do
  let(:request)     { Request.create!(name: "animal", query: "animal") }
  let(:photo)       { request.photos.first }
  let(:url_thumb)   { /(https\:\/\/images\.unsplash\.com).*(w=200)/ }
  let(:url_regular) { /(https\:\/\/images\.unsplash\.com).*(w=1080)/ }
  let(:url_link)    { /https\:\/\/unsplash\.com\/photos\/.{11}/ }
  let(:user_name)   { /\w+\s\w+/ }
  let(:user_link)   { /https\:\/\/unsplash\.com\/@./ }

  describe "#url_thumb" do
    it "returns url for thumb size photo" do
      expect(photo.url_thumb).to match(url_thumb)
    end
  end

  describe "#url_regular" do
    it "returns url for regular size photo" do
      expect(photo.url_regular).to match(url_regular)
    end
  end

  describe "#url_link" do
    it "returns url for original photo" do
      expect(photo.url_link).to match(url_link)
    end
  end

  describe "#user_name" do
    it "returns user name" do
      expect(photo.user_name).to match(user_name)
    end
  end

  describe "#user_link" do
    it "returns user name" do
      expect(photo.user_link).to match(user_link)
    end
  end
end
