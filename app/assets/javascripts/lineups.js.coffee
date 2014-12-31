ready = ->
  $("#calculator_players").select2
    width: 'resolve'
$(document).ready(ready)
$(document).on('page:load', ready)
