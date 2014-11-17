# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

ready = ->
  console.log('>>>trip#ready')

  calendar = $('#calendar')
  startDate = calendar.attr('data-start-date')

  calendar.fullCalendar({
    defaultDate: startDate
    ,droppable: true
    ,drop: (date, allDay) ->
        console.log('>>>trip#drop')

        element = $(this)
        update(element.attr('data-id'), date, element.text(), element)

        console.log('<<<trip#drop')
    ,editable: true
    ,eventClick: (event, jsEvent, view) ->
      console.log('>>>trip#calendar#eventClick')

      $(".area[data-id=#{event.area_id}] a")[0].click()

      console.log('<<<trip#calendar#eventClick')
    ,header: {
      left: 'prev'
      ,center: 'title'
      ,right: 'next'

    }
    ,eventDrop: (event, delta, revertFunc, jsEvent, ui, view) ->
      console.log('>>>trip#calendar#eventDrop')

      update(event.area_id, event.start, event.title, undefined)

      console.log('<<<trip#calendar#eventDrop')
  })

  $('.area').draggable()

  console.log('<<<trip#ready')

update = (area_id, date, title, element) ->
  console.log('>>>trip#update')

  trip_id = $('#trip').attr('data-id')
  url = "/trips/#{trip_id}/areas/#{area_id}"

  $.ajax({
    type: 'PUT'
    ,url: url
    ,data: { area: { proposed_date: date.toDate() } }
    ,dataType: 'json'
    ,success: ->
      console.log('>>>trip#update#postSuccess')

      if element != undefined
        listedArea = element.data('eventObject')
        calendarArea = $.extend({}, listedArea)
        calendarArea.start = date
        calendarArea.title = title
        calendarArea.area_id = area_id
        $('#calendar').fullCalendar('renderEvent', calendarArea, true)
        element.hide()

      console.log('<<<trip#update#postSuccess')
  }).done

  console.log('<<<trip#update')

$(document).ready(ready)
$(document).on('page:load', ready)
