module RequestsHelper
  def random_photo_for(query_name)
    request = Request.find_by(name: query_name)
    request.photos.sample.id if request
  end
end
