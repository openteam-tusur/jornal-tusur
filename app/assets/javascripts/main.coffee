$(document).on 'ready page:load', ->

  init_toggle_subnavigation() if $('.js-init-subnanigation').length
  init_collapse() if $('.js-simple-collapser').length
  init_colorbox() if $('a.colorbox').length
  init_overlay() if $('.js-init-overlay').length


  Turbolinks.enableProgressBar()

  $(document).on 'click', 'a.disabled', ->
    return false

  return
