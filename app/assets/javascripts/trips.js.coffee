# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

ready = ->
  console.log('>>>trip#ready')
  initializeCalendar()
  initializeAreas()
  initializeHeader()
  console.log('<<<trip#ready')


initializeCalendar = ->
  console.log('>>>trip#initializeCalendar')
  calendar = $('#calendar')
  startDate = calendar.attr('data-start-date')
  calendar.fullCalendar(
    defaultDate: startDate
    ,droppable: true
    ,drop: dropAreaOnCalendar
    ,editable: true
    ,eventClick: clickEventOnCalendar
    ,header:
      left: 'prev'
      ,center: 'title'
      ,right: 'next'
    ,events: convertAreasToEvents()
    ,eventDrop: moveEventAroundCalendar
  )
  console.log('<<<trip#initializeCalendar')


initializeAreas = ->
  console.log('>>>trip#initializeAreas')
  $('.area.bg-info').draggable(revert: revertDraggedArea)
  console.log('<<<trip#initializeAreas')


initializeHeader = ->
  console.log('>>>trip#initializeHeader')
  $('.jumbotron').each (index, element) =>
    tripBackground = $(element).attr('data-background')
    $(element).css('background-image', "url(#{tripBackground})")
  console.log('<<<trip#initializeHeader')


convertAreasToEvents = ->
  console.log('>>>trip#loadEvents')
  events = [];
  for area in $('.area[data-proposed-date!=""]')
    events.push
      title: "#{$(area).text()}#{$(area).attr('data-cost')}"
      ,start: $(area).attr('data-proposed-date')
      ,allDay: true
      ,area_id: $(area).attr('data-id')
  console.log('<<<trip#loadEvents')
  events


dropAreaOnCalendar = (date, allDay) ->
  console.log('>>>trip#drop')
  element = $(this)
  title = "#{element.text()}$#{element.attr('data-cost')}"
  updateAreasProposedDate(element.attr('data-id'), date, title, element)
  console.log('<<<trip#drop')


moveEventAroundCalendar =  (event, delta, revertFunc, jsEvent, ui, view) ->
  console.log('>>>trip#calendar#eventDrop')
  updateAreasProposedDate(event.area_id, event.start, event.title, undefined)
  console.log('<<<trip#calendar#eventDrop')


clickEventOnCalendar = (event, jsEvent, view) ->
  console.log('>>>trip#calendar#eventClick')
  $(".area[data-id=#{event.area_id}] a")[0].click()
  console.log('<<<trip#calendar#eventClick')


addAreaToCalendar = (data, status, request) ->
  console.log('>>>trip#update#postSuccess')
  if element != undefined
    listedArea = element.data('eventObject')
    calendarArea = $.extend({}, listedArea)
    calendarArea.start = date
    calendarArea.title = title
    calendarArea.area_id = area_id
    $('#calendar').fullCalendar('renderEvent', calendarArea, true)
    element.removeClass('bg-info').draggable('disable')
  console.log('<<<trip#update#postSuccess')


revertDraggedArea = (event, ui) ->
  console.log('>>>trip#revertDraggedArea')
  $(this).data("uiDraggable").originalPosition = { top : 0, left : 0 }
  console.log('<<<trip#revertDraggedArea')
  !event


updateAreasProposedDate = (area_id, date, title, element) ->
  console.log('>>>trip#update')
  trip_id = $('#trip').attr('data-id')
  url = "/trips/#{trip_id}/areas/#{area_id}"
  $.ajax({
    type: 'PUT'
    ,url: url
    ,data: { area: { proposed_date: date.toDate() } }
    ,dataType: 'json'
    ,success: (data, status, request) ->
      console.log('>>>trip#update#postSuccess')
      if element != undefined
        listedArea = element.data('eventObject')
        calendarArea = $.extend({}, listedArea)
        calendarArea.start = date
        calendarArea.title = title
        calendarArea.area_id = area_id
        $('#calendar').fullCalendar('renderEvent', calendarArea, true)
        element.removeClass('bg-info').draggable('disable')
      console.log('<<<trip#update#postSuccess')
  }).done
  console.log('<<<trip#update')


$(document).ready(ready)
$(document).on('page:load', ready)
