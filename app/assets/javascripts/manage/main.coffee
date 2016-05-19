$(document).on 'ready page:change', ->

  Turbolinks.enableProgressBar()

  $(document).on 'click', 'a.disabled', ->
    return false

  return
