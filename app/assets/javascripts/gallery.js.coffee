# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#$ ->  $('#filter').change -> 
#  x = $('#filter option:selected').val().toLowerCase()
#  if x == 'all' or x == ''
#    $('.thumbnail').show() 
#  else
#    $('.thumbnail').hide()
#    $('#filter option:selected').each ->
#      $('.' + x).show()
scrollThumbs = ->
  $ul = $('#viewport ul').first()
  pos = $ul.position().left
  pos -= $ul.children(0).width()
  $ul.animate {left: pos + 'px'}, 1000
  #, scrollThumbs()
$ ->
  $('#viewport').mouseover ->
    scrollThumbs()
#    $ul = $('#viewport ul').first()
#    pos = $ul.position().left
#    pos -= $ul.children(0).width()
#    $ul.animate {left: pos + 'px'}, 100
$ ->
  $('#viewport').mouseout ->
    $('#viewport ul').stop()
$ ->
  $('#ml').click ->
    obj = $('ul', $('#viewport'))
    pos = obj.position().left
    if pos > -600
      pos = pos - 300
	    obj.animate({left: pos + "px"}, 1000)
$ ->
  $('#mr').click ->
    obj = $('ul', $('#viewport'))
    pos = obj.position().left
    if pos < 0
      pos = pos + 300
	    obj.animate({left: pos + "px"}, 1000)
	    
$ ->
  $('#test').click ->
    alert $('#viewport img').eq(3).width()

