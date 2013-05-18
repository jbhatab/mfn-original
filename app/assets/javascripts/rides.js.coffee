$ ->
  $('.comment-link').click ->
    $(this).parent('h4').parent('.row-fluid').siblings('.ride-comments').slideToggle( 200, 'linear' )
