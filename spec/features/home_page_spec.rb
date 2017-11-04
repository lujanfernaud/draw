require 'rails_helper'

RSpec.feature "Home page", type: :feature do
  scenario "User visits home page" do
    visit root_url

    expect(page).to have_text("draw")
    expect(page).to have_css(".slogan")

    expect(page).to have_selector(:link_or_button, "female")
    expect(page).to have_selector(:link_or_button, "male")
    expect(page).to have_selector(:link_or_button, "face")
    expect(page).to have_selector(:link_or_button, "animal")
    expect(page).to have_selector(:link_or_button, "flower")
    expect(page).to have_selector(:link_or_button, "home")
    expect(page).to have_selector(:link_or_button, "landscape")
  end
end
