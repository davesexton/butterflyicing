# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $('.gallery').length > 0 || $('.gallery_images').length > 0
    $('.lightBox').lightBox()
    $('#galleryDisplay select').change ->
      @.onchange = $(@).parent('form').submit()
