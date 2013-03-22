$ ->
  $('.comment-link').click ->
    $(this).parent('h4').siblings('.ride-comments').fadeToggle( 200, 'linear' )