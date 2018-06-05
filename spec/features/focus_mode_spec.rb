require 'rails_helper'

RSpec.feature "ShowPhotos", vcr: VCR_OPTIONS, type: :feature do
  let(:query)   { "animal" }
  let(:request) { Request.create!(name: query, query: query) }
  let(:first_photo)  { request.photos.first }
  let(:second_photo) { request.photos.second }

  let(:second_photo_path) do
    request_photo_path(request_id: query, id: second_photo.id)
  end

  let(:photo_path)       { /\/\d+/ }
  let(:query_index_path) { request_photos_path(request_id: query) }

  scenario "user visits photo" do
    visit_first_photo

    expect(page).to have_css("img")
    expect(page).to have_text("Photo by")
    expect(page).to have_link("Unsplash")
  end

  scenario "user visits next photo" do
    visit_first_photo

    find("a", class: "next-photo-link").click

    expect(page).to have_current_path(second_photo_path)
  end

  scenario "user selects 'list mode' from menu" do
    visit_first_photo

    find("a", class: "navbar-brand").click
    click_on "list mode"

    expect(page).to have_current_path(query_index_path)
  end

  scenario "user selects 'focus mode' from menu" do
    visit_first_photo

    find("a", class: "navbar-brand").click
    click_on "list mode"
    click_on "focus mode"

    expect(current_path).to match(photo_path)
  end

  scenario "user goes back home" do
    visit_first_photo

    find("a", class: "navbar-brand").click
    click_on "home"

    expect(page).to have_current_path(root_path)
  end

  def visit_first_photo
    visit request_photo_path(request_id: query, id: first_photo.id)
  end
end
