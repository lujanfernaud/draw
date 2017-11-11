module PhotosHelper
  def low_resolution(photo_url)
    photo_url.sub(/w=200/, "w=150")
  end
end
