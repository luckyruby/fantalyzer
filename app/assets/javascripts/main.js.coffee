clear_text = ->
  $('.clear_on_focus').focus (e) ->
    $(this).val('')
ready = ->
  clear_text()
  $('.ajax_search')
    .bind "ajax:beforeSend", (evt, xhr, settings) ->
      $('.spinner').show()
    .bind "ajax:success", (evt, xhr, settings) ->
      $('.spinner').hide()
$(document).ready(ready)
$(document).on('page:load', ready)
