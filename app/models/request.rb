class Request < ApplicationRecord
  serialize     :results
  before_create :assign_results

  def photo
    prepare_photo
    @selected_photo
  end

  def updated_today?
    updated_at.today?
  end

  def update
    assign_results
  end

  private

    def assign_results
      self.results = get_results_for_reference
    end

    def get_results_for_reference
      YAML.dump(get_pages)
    end

    def get_pages
      get_page(rand(1..9)) + get_page(rand(10..19)) + get_page(rand(20..30))
    end

    def get_page(page_number)
      Unsplash::Photo.search(reference, page = page_number, per_page = 30)
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
      YAML.load(results).shuffle
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