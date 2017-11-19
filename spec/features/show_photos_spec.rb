require 'rails_helper'

RSpec.feature "ShowPhotos", vcr: VCR_OPTIONS, type: :feature do
  let(:query)   { "animal" }
  let(:request) { Request.create!(name: query, query: query) }
  let(:first_photo)  { request.photos.first }
  let(:second_photo) { request.photos.second }

  let(:second_photo_path) do
    request_photo_path(request_id: query, id: second_photo.id)
  end

  scenario "user visits photo" do
    visit request_photo_path(request_id: query, id: first_photo.id)

    expect(page).to have_css("img")
    expect(page).to have_text("Photo by")
    expect(page).to have_link("Unsplash")
  end

  scenario "user clicks photo" do
    visit request_photo_path(request_id: query, id: first_photo.id)

    find("a", class: "photo-link").click

    expect(page).to have_current_path(second_photo_path)
  end
end
