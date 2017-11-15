class Photo < ApplicationRecord
  belongs_to :request
  serialize  :object

  def url_thumb
    object.urls.thumb
  end

  def url_regular
    object.urls.regular
  end

  def url_link
    object.links.html
  end

  def user_name
    object.user.name
  end

  def user_link
    object.user.links.html
  end
end
