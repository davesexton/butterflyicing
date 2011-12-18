# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->  $('#filter').change( -> 
  x = $('#filter option:selected').val().toLowerCase()
  if x == 'all' or x == ''
    $('.thumbnail').show() 
  else
    $('.thumbnail').hide()
    $('#filter option:selected').each( ->
      $('.' + x).show()
    )
)
