@init_languages = ->

  $('.js-languages').chosen
    disable_search_threshold: 10
  .change (e) ->
    window.location.replace "/#{$(e.target).val()}"
    return

  return
