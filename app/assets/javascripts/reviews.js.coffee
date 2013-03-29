$ ->
  $('.rating_star').hover \
    (-> $(this).prevAll().andSelf().addClass('active-star')), \
    (-> $(this).prevAll().andSelf().removeClass('active-star'))