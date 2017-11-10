require 'rails_helper'

RSpec.describe PhotosHelper, type: :helper do
  describe "#low_resolution" do
    let(:image) { "https://images.unsplash.com/photo-1458530553242-34a1bdf98213?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=71f844deb4f6a478d260b83fbc929405" }

    it "returns url with an image width smaller than 200" do
      expect(low_resolution(image)).to_not match(/w=200/)
    end
  end
end
