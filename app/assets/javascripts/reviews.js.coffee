$ ->
  rating_toggle = true
  $(".rating_star").on("mouseenter", ->
    $(this).prevAll().andSelf().addClass "active-star"  if rating_toggle
  ).on("mouseleave", ->
    $(this).siblings().andSelf().removeClass "active-star"  if rating_toggle
  ).on "click", ->
    rating_toggle = (if rating_toggle then false else true)
    if !rating_toggle
      star = $(this)
      form_id = star.attr('data-form-id')
      stars = star.attr('data-stars')
      console.log(stars)
      $.ajax
        type: "post"
        url: $("#"+form_id).attr("action")
        data: $("#"+form_id).serialize()
      

  meter_toggle = true
  $(".rating_meter").on("mouseenter", ->
    meter_id = $(this).attr("id")
    $(this).parent(".security_rating").addClass(meter_id)  if meter_toggle
  ).on("mouseleave", ->
    meter_id = $(this).attr("id")
    $(this).parent(".security_rating").removeClass(meter_id)  if meter_toggle
  ).on "click", ->
    meter_toggle = (if meter_toggle then false else true)


