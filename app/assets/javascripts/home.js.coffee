# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
swapImages = (id) ->
  $(".#{id}").each ->
    active = $(@).children(".imgShow")
    if active.next().get(0)
      next = active.next()
    else
      next = $(@).children("img").first()
    active.fadeOut ->
      active.removeClass('imgShow').addClass 'imgHide'
      next.fadeIn('slow').addClass 'imgShow'

setInterval ->
  swapImages "imgRotor"
, 5000

