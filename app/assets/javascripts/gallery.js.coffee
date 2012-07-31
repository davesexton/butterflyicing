# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $('.gallery').length > 0
    console.log 'hi'
#    h = $(window).height()
#    w = $(window).width()
#    x = w / 2 - 180
#    y = h / 2 - 135
#    # 360 270

    $('#galleryDisplay a').lightBox()
#      $(@).attr('href', 'javascript:void(0);').click (e)->
#        e.preventDefault
#        $('#imgViewer').css(
#          'background-color':'#00F',
#          'position':'fixed',
#          'top': "#{y}px",
#          'left':"#{x}px",
#          'width':'180px',
#          'height':'135px'
#        )
#        url = $(@).children('img').attr('src')
#        url = url.replace /_thumbnail/, ''
#        url = url.replace /\.jpg/, ''
#        url = url.replace /\/assets/, ''

#        $('#imgViewer').load url, (e)->
#          $(@).animate(
#            {'width': $(@).children('img').width() + 'px',
#            'height': $(@).children('img').height() + 'px'},
#            'slow'
#          )
#        #  console.log 'hi'
