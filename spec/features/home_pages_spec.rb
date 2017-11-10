require 'rails_helper'

RSpec.feature "Home page", type: :feature do
  scenario "User visits home page" do
    visit root_url

    expect(page).to have_text("draw")
    expect(page).to have_selector(:link_or_button, "female")
  end
end
