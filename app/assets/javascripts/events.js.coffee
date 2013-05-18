$ ->
  $('.event-list-date').datepicker
    dateFormat: 'yy-mm-dd'

  $("#event_search input").keyup ->
    $.get $("#event_search").attr("action"), $("#event_search").serialize(), null, "script"
    false


