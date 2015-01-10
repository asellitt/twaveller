# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  console.log('>>>trip_rights#ready')
  initializeRows()
  console.log('<<<trip_rights#ready')

initializeRows = ->
  console.log('>>>trip_rights#initializeRows')
  $('.clickable-row').click ->
    url = $(this).attr('data-url')
    window.document.location = url
  console.log('<<<trip_rights#initializeRows')

$(document).ready(ready)
$(document).on('page:load', ready)
