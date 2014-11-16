# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  console.log('>>>trip#ready')

  calendar = $('#calendar')
  startDate = calendar.attr('data-start-date')

  calendar.fullCalendar({
     header: {
      left: 'prev'
      ,center: 'title'
      ,right: 'next'

    },
    ,defaultDate: startDate
    ,droppable: true
    ,drop: drop
  })

  $('.area').draggable()

  console.log('<<<trip#ready')

drop = (moment, allDay) ->
  console.log('>>>trip#drop')
  console.log("Dropped on " + moment.format() + " with allDay=" + allDay)
  console.log('<<<trip#drop')

$(document).ready(ready)
$(document).on('page:load', ready)
