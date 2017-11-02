require 'rails_helper'

RSpec.feature "Home page", type: :feature do
  scenario "User visits home page" do
    visit root_url

    expect(page).to have_text("draw")
    expect(page).to have_css(".slogan")
    expect_page_to_have_links_to_queries
  end

  private

    def expect_page_to_have_links_to_queries
      Request.allowed_queries.each do |query|
        expect(page).to have_selector(:link_or_button, query)
      end
    end
end
