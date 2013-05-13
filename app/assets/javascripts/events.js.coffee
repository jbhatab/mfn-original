$ ->
  $('#start-at-field').datepicker
    dateFormat: 'yy-mm-dd'

  $('#end-at-field').datepicker
    dateFormat: 'yy-mm-dd'

  $("#event_search input").keyup ->
    $.get $("#event_search").attr("action"), $("#event_search").serialize(), null, "script"
    false
