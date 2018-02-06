class PhotoDecorator
  attr_reader :photo, :view_context, :width, :height

  delegate :id, to: :photo

  REFERENCE_WIDTH  = 1140.0
  REFERENCE_HEIGHT = 1710.0

  def initialize(photo)
    @photo  = photo
    @width  = 0
    @height = 0

    size_image_relative_to_reference_values
  end

  def url_thumb
    photo.object.urls.thumb.sub(/q=80/, "q=10").sub(/w=200/, "w=100")
  end

  def url_regular
    photo.object.urls.regular.sub(/w=1080/, "w=1140")
  end

  def url_link
    photo.object.links.html
  end

  def user_name
    photo.object.user.name
  end

  def user_link
    photo.object.user.links.html
  end

  private

    # We do this to get the maximum size of the image adapted
    # to the maximum main container width that we are using, 1140px.
    # This is the size that the image will have when showed fully.
    # We use this values in 'data' attributes in the '.photo-container'
    # class. Then with JavaScript, the '.photo-container' is adapted
    # to the viewport size. This way we can properly lazyload the images.
    def size_image_relative_to_reference_values
      width_ratio  = REFERENCE_WIDTH  / photo_width
      height_ratio = REFERENCE_HEIGHT / photo_height

      resize_ratio = [width_ratio, height_ratio].min

      @width  = (resize_ratio * photo_width).to_i
      @height = (resize_ratio * photo_height).to_i
    end

    def photo_width
      photo.object.width
    end

    def photo_height
      photo.object.height
    end
end
