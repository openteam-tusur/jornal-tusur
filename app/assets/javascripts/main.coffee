$(document).on 'ready page:load', ->

  Turbolinks.enableProgressBar()

  $(document).on 'click', 'a.disabled', ->
    return false

  return
