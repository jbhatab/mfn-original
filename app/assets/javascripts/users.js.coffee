$ ->
  $( "#inbox" ).accordion({ active: 1000000, header: "header" })
  $( "#outbox" ).accordion({ active: 1000000})
  $('.message-header').click ->
    $(this).removeClass('unopened')


	
