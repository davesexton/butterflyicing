# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $('.gallery').length > 0
    $('#galleryDisplay a').each ()->
      $(@).attr('href', 'javascript:void(0);').click (e) ->
        e.preventDefault
        url = $(@).children('img').attr('src')
        url = url.replace /_thumbnail/, ''
        url = url.replace /\.jpg/, ''
        url = url.replace /\/assets/, ''
        $('#imgViewer').load url, (e)->
          console.log 'hi'
