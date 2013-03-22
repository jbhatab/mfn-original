$ ->
  $('.comment-link').click ->
    $(this).parent('h4').siblings('.ride-comments').slideToggle( 200, 'linear' )