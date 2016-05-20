@init_user_autocomplete = ->

  input = $('.js-user-autocomplete')
  target = $('.js-user-autocomplete-target')

  return if !input.length || !target.length

  input.autocomplete
    source: input.data('url')
    minLength: 2
    select: (event, ui) ->
      target.val(ui.item.id)
      return

  return
