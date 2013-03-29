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
      $("#"+form_id+"_rating").val(stars);
      $.ajax
        type: "POST"
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
    if !meter_toggle
      meter = $(this)
      form_id = meter.attr('data-form-id')
      meters = meter.attr('data-meters')
      $("#"+form_id+"_security").val(meters);
      $.ajax
        type: "POST"
        url: $("#"+form_id).attr("action")
        data: $("#"+form_id).serialize()

  $('#adv-form-toggle').click (e) ->
    e.preventDefault()
    $(this).siblings('.adv-form-container').slideToggle 200
    

