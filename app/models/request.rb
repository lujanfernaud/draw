class Request < ApplicationRecord
  serialize     :results
  before_create :assign_request_results

  FIRST_PAGE  = 1
  LAST_PAGE   = 115
  PAGE_RANGES = [FIRST_PAGE..25, 30..55, 60..85, 90..LAST_PAGE]

  def self.allowed_queries
    ["woman-girl",
     "man-boy",
     "face-woman-girl-man-boy",
     "animal",
     "flower",
     "home",
     "landscape"].freeze
  end

  def photo
    prepare_photo
    @selected_photo
  end

  def updated_today?
    updated_at.today?
  end

  def update_photos
    clear_current_pages
    clear_visited_photos
    assign_request_results
    save!
  end

  private

    def clear_current_pages
      update_column(:current_pages, [])
    end

    def clear_visited_photos
      update_column(:visited_photos, [])
    end

    def assign_request_results
      self.results = get_results_for_query
    end

    def get_results_for_query
      prepare_pages
      YAML.dump(pages)
    end

    def prepare_pages
      prepare_current_pages
      prepare_previous_pages
    end

    def prepare_current_pages
      PAGE_RANGES.each do |page_range|
        current_pages << select_page_in(page_range)
      end
    end

    def select_page_in(range)
      page = rand(range)
      page = rand(range) while previous_pages.include?(page)
      page
    end

    def prepare_previous_pages
      update_column(:previous_pages, []) if persisted?

      current_pages.each do |page|
        previous_pages << page - 1 unless page == FIRST_PAGE
        previous_pages << page
        previous_pages << page + 1 unless page == LAST_PAGE
      end
    end

    def pages
      get_page(current_pages.first)    +
        get_page(current_pages.second) +
        get_page(current_pages.third)  +
        get_page(current_pages.fourth)
    end

    def get_page(page_number)
      Unsplash::Photo.search(query, page = page_number, per_page = 7)
    end

    def prepare_photo
      select_photo
      add_selected_photo_to_visited_photos
      clear_visited_photos if all_photos_have_been_visited?
    end

    def select_photo
      @selected_photo = parsed_results.sample
      select_another_photo while photo_has_been_visited?
    end

    def select_another_photo
      @selected_photo = parsed_results.sample
    end

    def parsed_results
      YAML.load(results)
    end

    def photo_has_been_visited?
      visited_photos.include?(@selected_photo.id)
    end

    def add_selected_photo_to_visited_photos
      visited_photos << @selected_photo.id
      save!
    end

    def all_photos_have_been_visited?
      (parsed_results.size - visited_photos.size).zero?
    end
end
