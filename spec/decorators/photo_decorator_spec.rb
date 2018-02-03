require 'rails_helper'

RSpec.describe PhotoDecorator, vcr: VCR_OPTIONS, type: :model do
  let(:request)         { Request.create!(name: "animal", query: "animal") }
  let(:photo)           { request.photos.first }
  let(:photo_decorator) { PhotoDecorator.new(photo) }

  let(:url_thumb)       { /(https\:\/\/images\.unsplash\.com).*(w=150)/ }
  let(:url_regular)     { /(https\:\/\/images\.unsplash\.com).*(w=1140)/ }
  let(:url_link)        { /https\:\/\/unsplash\.com\/photos\/.{11}/ }
  let(:user_name)       { /\w+\s+\w+/ }
  let(:user_link)       { /https\:\/\/unsplash\.com\/@./ }

  let(:fake_photo_landscape) { FakePhoto.new(width: 5512, height: 3675) }
  let(:fake_photo_portrait)  { FakePhoto.new(width: 2148, height: 3222) }

  describe "#width" do
    it "returns maximum width based on the 1140px container width" do
      photo_landscape_decorator = PhotoDecorator.new(fake_photo_landscape)
      expect(photo_landscape_decorator.width).to eq(1140)

      photo_portrait_decorator = PhotoDecorator.new(fake_photo_portrait)
      expect(photo_portrait_decorator.width).to eq(1140)
    end
  end

  describe "#height" do
    it "returns maximum height based on the 1140px container width" do
      photo_landscape_decorator = PhotoDecorator.new(fake_photo_landscape)
      expect(photo_landscape_decorator.height).to eq(760)

      photo_portrait_decorator = PhotoDecorator.new(fake_photo_portrait)
      expect(photo_portrait_decorator.height).to eq(1710)
    end
  end

  describe "#url_thumb" do
    it "returns url for thumb size photo" do
      expect(photo_decorator.url_thumb).to match(url_thumb)
    end
  end

  describe "#url_regular" do
    it "returns url for regular size photo" do
      expect(photo_decorator.url_regular).to match(url_regular)
    end
  end

  describe "#url_link" do
    it "returns url for original photo" do
      expect(photo_decorator.url_link).to match(url_link)
    end
  end

  describe "#user_name" do
    it "returns user name" do
      expect(photo_decorator.user_name).to match(user_name)
    end
  end

  describe "#user_link" do
    it "returns user name" do
      expect(photo_decorator.user_link).to match(user_link)
    end
  end
end

class FakePhoto
  attr_reader :object

  PhotoObject = Struct.new(:width, :height)

  def initialize(width:, height:)
    @object = PhotoObject.new(width, height)
  end
end
