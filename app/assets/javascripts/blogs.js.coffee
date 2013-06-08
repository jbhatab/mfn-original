$(document).delegate "#blog-content-input", "keydown", (e) ->
  keyCode = e.keyCode or e.which
  if keyCode is 9
    e.preventDefault()
    start = $(this).get(0).selectionStart
    end = $(this).get(0).selectionEnd
    
    # set textarea value to: text before caret + tab + text after caret
    $(this).val $(this).val().substring(0, start) + "\t" + $(this).val().substring(end)
    
    # put caret at right position again
    $(this).get(0).selectionStart = $(this).get(0).selectionEnd = start + 1