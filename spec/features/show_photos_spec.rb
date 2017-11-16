require 'rails_helper'

RSpec.feature "ShowPhotos", :vcr, type: :feature do
  let(:query) { "animal" }
  let(:photo) { Request.find_by(query: query).photos.first }

  scenario "user visits photo" do
    visit request_photo_path(request_id: query, id: photo.id)

    expect(page).to have_css("img")
    expect(page).to have_text("Photo by")
    expect(page).to have_link("Unsplash")
  end
end
