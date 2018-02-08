require 'rails_helper'

RSpec.feature "ListMode", vcr: VCR_OPTIONS, type: :feature do
  let(:query)            { "animal" }
  let(:request)          { Request.create!(name: query, query: query) }
  let(:first_photo)      { request.photos.first }
  let(:last_photo)       { request.photos.last }
  let(:query_index_path) { request_photos_path(request_id: query) }

  scenario "user visits list mode" do
    visit_list_mode

    number_of_photos = request.results.size

    expect(page).to have_current_path(query_index_path)
    expect(page).to have_css(".row-photo", count: number_of_photos)
    expect(page).to have_css(".photo-navigation", count: number_of_photos)
  end

  scenario "up arrow is not visible on first photo" do
    visit_list_mode

    within "##{first_photo.id}" do
      expect(page).to have_css("div.navigation__arrow--up.visibility-hidden")
    end
  end

  scenario "down arrow is not visible on last photo" do
    visit_list_mode

    within "##{last_photo.id}" do
      expect(page).to have_css("div.navigation__arrow--down.visibility-hidden")
    end
  end

  def visit_list_mode
    visit_first_photo

    find("a", class: "navbar-brand").click
    find("a", class: "dropdown-item", text: "list mode").click
  end

  def visit_first_photo
    visit request_photo_path(request_id: query, id: first_photo.id)
  end
end
