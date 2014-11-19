# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  console.log('>>>area#ready')
  initializeAreas()
  console.log('<<<area#ready')

initializeAreas = ->
  console.log('>>>area#initializeHeader')
  $('.image').each( (index) ->
    background = $(this).attr('data-background')
    $(this).css('background-image', "url(#{background})")
  )
  console.log('<<<area#initializeHeader')


$(document).ready(ready)
$(document).on('page:load', ready)
