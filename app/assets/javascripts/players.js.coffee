ready = ->
  $('.line').sparkline 'html',
    type: 'line'
    width: '100px'
    height: '30px'

  $('.discrete').sparkline 'html',
    type: 'discrete'

  $('.box').sparkline 'html',
    type: 'box'
    width: '100px'
    height: '30px'

  $('.clickable').click (e) ->
    e.preventDefault
    player_id = $(this).data('player')
    $.get "players/#{player_id}/games",{},null,'script'

  $.tablesorter.addParser
    id: "mean_fp"
    is: (s) ->
      # return false so this parser is not auto detected
      false
    format: (s) ->
      # format your data for normalization
      return parseFloat(s.split(" ")[0])
    parsed: true
    type: "numeric"

  $('#players_table').tablesorter
    theme: 'bootstrap'
    headerTemplate: '{content} {icon}'
    widgets: ["uitheme", "filter", "resizable"]
    widgetOptions:
      resizable: true
      resizable_widths: ['250px', '40px']
    headers:
      1:
        sorter: false
      2:
        sorter: "mean_fp"
      9:
        sorter: false
        filter: false
      10:
        sorter: false
        filter: false
$(document).ready(ready)
$(document).on('page:load', ready)