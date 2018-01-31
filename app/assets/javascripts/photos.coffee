$(document).on "turbolinks:load", ->
  lazySizes.init()
  allowPhotoResize()

allowPhotoResize = ->
  rowSpacing = 9

  $(".photo-container").ready ->
    $(".photo").hover ->
      rowPhoto = $(this).parents(".row-photo")
      photo    = $(this)

      if photoIsBiggerThanContainer(rowPhoto, photo, rowSpacing)
        photo.toggleClass "cursor-resize"
        photo.on "click", ->
          photo.toggleClass "photo-max-height"
          scrollToPhotoTop(rowPhoto, photo)

photoIsBiggerThanContainer = (rowPhoto, photo, rowSpacing) ->
  if listModeIsActive(rowPhoto)
    rowPhoto.width() - photo.width() > rowSpacing
  else if focusModeIsActive(rowPhoto)
    rowPhoto.height() - photo.height() < rowSpacing

scrollToPhotoTop = (rowPhoto, photo) ->
  if listModeIsActive(rowPhoto)
    navbarOffset = 1
  else if focusModeIsActive(rowPhoto)
    navbarOffset = 50

  $("html, body").animate({
    scrollTop: photo.offset().top - $(".navbar").outerHeight() - navbarOffset
  }, 0);

listModeIsActive = (rowPhoto) ->
  rowPhoto.hasClass("row-photo--list")

focusModeIsActive = (rowPhoto) ->
  rowPhoto.hasClass("row-photo--focus")
