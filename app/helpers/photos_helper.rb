module PhotosHelper
  def hide_if_first(index)
    if index == 0
      "visibility-hidden"
    end
  end

  def hide_if_last(index, object)
    if index == object.length - 1
      "visibility-hidden"
    end
  end
end
