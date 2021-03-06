$(document).on "turbolinks:load", ->
  lazySizes.init()
  clearTurbolinksCacheOnCategoryClick()
  sizePhotoContainer()
  allowPhotoResize()
  menuBackgroundOverlay()
  fadeOutWhenGoingBackHome()


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

      # This seems to be needed as sometimes landscape images were pre-loading
      # with a height bigger than what was available in the viewport.
      if height > maxHeight
        newRatio = maxHeight / photoHeight
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
  focusHeightOffset = 10
  listHeightOffset  = 20

  $(".photo-footer--focus").outerHeight(true) + focusHeightOffset ||
    $(".photo-footer--list").outerHeight(true) + listHeightOffset

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
  $(".photo-container").ready ->
    $(".photo").hover ->
      photo     = $(this)
      rowPhoto  = photo.parents(".row-photo")
      container = photo.parents(".photo-container")
      photoFullWidth = container.data("photo-width")

      if photoIsNotFullSize(photo, photoFullWidth)
        photo.toggleClass "cursor-resize"
        photo.on "click", ->
          toggleNavbar(rowPhoto)
          toggleElementsHeight(photo)
          scrollToPhotoTop(rowPhoto, photo)

photoIsNotFullSize = (photo, photoFullWidth) ->
  photo.width() < photoFullWidth

toggleNavbar = (rowPhoto) ->
  if focusModeIsActive(rowPhoto)
    $(".navbar").toggleClass "fixed-top"
    $(".main-container").toggleClass "pt-navbar"

toggleElementsHeight = (photo) ->
  photo.toggleClass "photo-max-height"
  $(".main-container").toggleClass "min-height-100vh"

scrollToPhotoTop = (rowPhoto, photo) ->
  if listModeIsActive(rowPhoto)
    navbarOffset = 7
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


# ------------------------
# fadeOutWhenGoingBackHome
# ------------------------


fadeOutWhenGoingBackHome = ->
  $(".dropdown-home").click ->
    $("body").addClass "fade-out"
