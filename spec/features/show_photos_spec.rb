require 'rails_helper'

RSpec.feature "ShowPhotos", :vcr, type: :feature do
  scenario "user visits photo" do
    visit "photos/animal"

    expect(page).to have_css("img")
    expect(page).to have_text("Photo by")
    expect(page).to have_link("Unsplash")
  end
end
