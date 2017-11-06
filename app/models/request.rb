class Request < ApplicationRecord
  serialize     :results
  before_create :assign_results

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

  def update
    assign_results
    clear_visited_photos
  end

  private

    def assign_results
      self.results = get_results_for_query
    end

    def get_results_for_query
      YAML.dump(get_pages)
    end

    # We choose a random page from four different groups,
    # with some pages in between, to try to increase the randomness.
    #
    def get_pages
      get_page(rand(1..20)) + get_page(rand(25..45)) +
        get_page(rand(50..70)) + get_page(rand(75..95))
    end

    def get_page(page_number)
      Unsplash::Photo.search(query, page = page_number, per_page = 6)
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
      self.save!
    end

    def clear_visited_photos
      update_attribute(:visited_photos, [])
    end

    def all_photos_have_been_visited?
      (parsed_results.size - visited_photos.size).zero?
    end
end
