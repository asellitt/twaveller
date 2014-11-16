# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
ready = ->
  console.log('>>>trip#ready')

  calendar = $('#calendar')
  startDate = calendar.attr('data-start-date')

  calendar.fullCalendar({
    defaultDate: startDate
    ,droppable: true
    ,drop: drop
    ,editable: true
    ,header: {
      left: 'prev'
      ,center: 'title'
      ,right: 'next'

    },
  })

  $('.area').draggable()

  console.log('<<<trip#ready')

drop = (moment, allDay) ->
  console.log('>>>trip#drop')

  listedArea = $(this).data('eventObject')
  calendarArea = $.extend({}, listedArea)
  calendarArea.start = moment
  calendarArea.title = $(this).text()
  $('#calendar').fullCalendar('renderEvent', calendarArea, true)
  $(this).remove()

  console.log('<<<trip#drop')

$(document).ready(ready)
$(document).on('page:load', ready)
