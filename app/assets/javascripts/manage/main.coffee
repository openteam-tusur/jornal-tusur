$(document).on 'ready page:change', ->

  Turbolinks.enableProgressBar()

  $(document).on 'click', 'a.disabled', ->
    return false

  init_user_autocomplete() if $('.js-user-autocomplete').length

  return
