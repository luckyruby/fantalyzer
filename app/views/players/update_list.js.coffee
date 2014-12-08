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

$('.collapse').on 'show.bs.collapse', ->
  player_id = $(this).data('player')
  $.get "players/#{player_id}/games",{},null,'script'

$('#games').empty()
