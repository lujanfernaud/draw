require 'rails_helper'

RSpec.feature "Home page", type: :feature do
  scenario "user visits home page" do
    visit root_url
    expect_page_to_be_home_page
  end

  scenario "user clicks on photo category", vcr: VCR_OPTIONS do
    query_name = "animal"
    create_request_for query_name

    visit_home
    click_on query_name

    expect(current_path).to match(/#{query_name}\/photos\/\d+/)
  end

  scenario "user clicks twice on photo category", vcr: VCR_OPTIONS do
    query_name = "animal"
    create_request_for query_name

    visit_home
    click_on query_name

    first_click_path = current_path.match(/#{query_name}\/photos\/\d+/)[0]
    expect(current_path).to match(first_click_path)

    visit_home
    click_on query_name

    second_click_path = current_path.match(/#{query_name}\/photos\/\d+/)[0]
    expect(current_path).to match(second_click_path)

    visit_home
    click_on query_name

    clicks_paths = [first_click_path, second_click_path]

    expect([current_path, current_path]).not_to match(clicks_paths)
  end

  private

    def visit_home
      visit root_url
      expect_page_to_be_home_page
    end

    def expect_page_to_be_home_page
      expect(page).to have_text("draw")
      expect(page).to have_css(".slogan")

      expect(page).to have_selector(:link_or_button, "female")
      expect(page).to have_selector(:link_or_button, "male")
      expect(page).to have_selector(:link_or_button, "face")
      expect(page).to have_selector(:link_or_button, "animal")
      expect(page).to have_selector(:link_or_button, "flower")
      expect(page).to have_selector(:link_or_button, "scenery")
    end

    def create_request_for(query_name)
      Request.create!(name: query_name, query: query_name)
    end
end
