$(document).on "turbolinks:load", ->
  lazySizes.init()
  clearTurbolinksCacheOnCategoryClick()
  sizePhotoContainer()
  allowPhotoResize()
  menuBackgroundOverlay()


# -----------------------------------
# clearTurbolinksCacheOnCategoryClick
# -----------------------------------


# We do this to prevent the last image that we saw in the category
# from appearing before the new random image is loaded.
clearTurbolinksCacheOnCategoryClick = ->
  $(".btn-category").click ->
    Turbolinks.clearCache()


# ------------------
# sizePhotoContainer
# ------------------


sizePhotoContainer = ->
  $(".photo-container").each ->
    container   = $(this)
    photo       = container.find(".photo")
    maxWidth    = container.parent().width()
    maxHeight   = viewportHeight() - navbarHeight() - photoFooterHeight()
    photoWidth  = container.data("photo-width")
    photoHeight = container.data("photo-height")

    if photoWidth > photoHeight
      ratio  = Math.min(maxWidth / photoWidth, maxHeight / photoHeight)
      width  = photoWidth  * ratio
      height = photoHeight * ratio

      if height > maxHeight
        newRatio = maxHeight / height
        width    = photoWidth  * newRatio
        height   = photoHeight * newRatio

    else
      ratio  = Math.min(maxWidth / photoWidth, maxHeight / photoHeight)
      width  = photoWidth  * ratio
      height = photoHeight * ratio

    sizeContainer(container, width, height)
    resetContainerSizeWhenPhotoIsLoaded(container, photo)

viewportHeight = ->
  Math.max(document.documentElement.clientHeight || window.innerHeight || 0)

navbarHeight = ->
  $(".navbar").outerHeight(true)

photoFooterHeight = ->
  heightOffset = 15

  $(".photo-footer--focus").outerHeight(true) + heightOffset ||
    $(".photo-footer--list").outerHeight(true) - heightOffset

sizeContainer = (container, width, height) ->
  container.css("width", width + "px")
  container.css("height", height + "px")

resetContainerSizeWhenPhotoIsLoaded = (container, photo) ->
  photo.on "lazyloaded", ->
    container.css("width", "auto")
    container.css("height", "auto")


# ----------------
# allowPhotoResize
# ----------------


allowPhotoResize = ->
  rowSpacing = 9

  $(".photo-container").ready ->
    $(".photo").hover ->
      rowPhoto = $(this).parents(".row-photo")
      photo    = $(this)

      if photoIsBiggerThanContainer(rowPhoto, photo, rowSpacing)
        photo.toggleClass "cursor-resize"
        photo.on "click", ->
          toggleNavbar(rowPhoto)
          photo.toggleClass "photo-max-height"
          scrollToPhotoTop(rowPhoto, photo)

photoIsBiggerThanContainer = (rowPhoto, photo, rowSpacing) ->
  if listModeIsActive(rowPhoto)
    rowPhoto.width() - photo.width() > rowSpacing
  else if focusModeIsActive(rowPhoto)
    rowPhoto.height() - photo.height() < rowSpacing

toggleNavbar = (rowPhoto) ->
  if focusModeIsActive(rowPhoto)
    $(".navbar").toggleClass "fixed-top"
    $(".main-container").toggleClass "pt-navbar"

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


# ---------------------
# menuBackgroundOverlay
# ---------------------


menuBackgroundOverlay = ->
  $(".dropdown").on "show.bs.dropdown", ->
    $(".main-container-overlay").toggleClass "main-container-overlay--visible"

  $(".dropdown").on "hide.bs.dropdown", ->
    $(".main-container-overlay").toggleClass "main-container-overlay--visible"
