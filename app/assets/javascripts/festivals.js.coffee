$ ->
  $('#yearTab a:last').tab('show')
  $('#yearTab a').click ->
    $(this).tab('show')

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()