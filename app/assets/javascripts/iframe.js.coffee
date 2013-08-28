$ ->
  $("form#login_form").bind "ajax:success", (e, data, status, xhr) ->
    if data.success
      $('#login_modal').modal('hide')
      $('#user_login_box').hide()
      $('#user_logged_in_box').show()
    else
      alert('failure!')

  $("form#signup_form").bind "ajax:success", (e, data, status, xhr) ->
    if data.success
      $('#login_modal').modal('hide')
      $('#user_login_box').hide()
      $('#user_logged_in_box').show()
    else
      alert('failure!')