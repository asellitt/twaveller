ready = ->
  console.log('>>>global#ready')
  initializePolaroids()
  console.log('<<<global#ready')

initializePolaroids = ->
  console.log('>>>global#initializePolaroids')
  $('.polaroid-image').each( (index) ->
    background = $(this).attr('data-background')
    $(this).css('background-image', "url(#{background})")
    $(this).css('background-position', "center")
  )
  console.log('<<<global#initializePolaroids')


$(document).ready(ready)
$(document).on('page:load', ready)
