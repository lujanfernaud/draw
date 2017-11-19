class Request < ApplicationRecord
  has_many      :photos, dependent: :destroy
  validates     :query, :name, uniqueness: true
  validates     :query, :name, presence: true
  serialize     :results
  before_create :assign_results

  FIRST_PAGE  = 1
  LAST_PAGE   = 135
  PAGE_RANGES = [FIRST_PAGE..30, 35..65, 70..100, 105..LAST_PAGE]
  PAGES       = PAGE_RANGES.count

  def self.allowed_queries
    {"female"    => "woman-girl",
     "male"      => "man-boy",
     "face"      => "facial-smile",
     "animal"    => "animal",
     "flower"    => "flower-bloom-blossom",
     "scenery"   => "landscape-scenery-field-coastal-lake"}.freeze
  end

  def next_photo_for(photo)
    return photos.first.id if photo.id == photos.last.id
    photo.id + 1
  end

  def updated_today?
    updated_at.today?
  end

  def update_photos
    clear_current_pages
    assign_results
    save!
  end

  private

    def clear_current_pages
      update_column(:current_pages, [])
    end

    def assign_results
      assign_request_results
      assign_photos
    end

    def assign_request_results
      self.results = get_results_for_query
    end

    def get_results_for_query
      prepare_pages
      pages
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

    def select_page_in(page_range)
      ([*page_range] - previous_pages).sample
    end

    def prepare_previous_pages
      clear_previous_pages if pages_for_three_days?

      current_pages.each do |page|
        previous_pages << page - 1 unless page == FIRST_PAGE
        previous_pages << page
        previous_pages << page + 1 unless page == LAST_PAGE
      end
    end

    def clear_previous_pages
      update_column(:previous_pages, [])
    end

    def pages_for_three_days?
      previous_pages.count >= disallowed_pages_per_day * 3
    end

    def disallowed_pages_per_day
      disallowed_pages_per_page = 3
      first_and_last_page       = 2
      PAGES * disallowed_pages_per_page - first_and_last_page
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

    def assign_photos
      photos.destroy_all
      results.each { |photo| photos.new(object: photo) }
    end
end
