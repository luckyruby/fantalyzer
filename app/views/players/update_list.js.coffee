$('#players').html("<%= escape_javascript(render 'list') %>")

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

$('[data-toggle="tooltip"]').tooltip()

$.tablesorter.addParser
  id: "mean"
  is: (s) ->
    # return false so this parser is not auto detected
    false
  format: (s) ->
    # format your data for normalization
    s.split(" ")[0]
  type: "numeric"

$('#players_table').tablesorter
  theme: 'bootstrap'
  headerTemplate: '{content} {icon}'
  widgets: ["uitheme", "filter"]
  headers:
    1:
      sorter: false
    2:
      sorter: "mean"
    7:
      sorter: false
      filter: false
    8:
      sorter: false
      filter: false
$('#games').empty()
