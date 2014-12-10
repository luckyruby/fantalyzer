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
  target = $(this).data('target')
  $(target).collapse('toggle')

$('.collapse').on 'show.bs.collapse', ->
  player_id = $(this).data('player')
  $.get "players/#{player_id}/games",{},null,'script'

$('[data-toggle="tooltip"]').tooltip()

$('#games').empty()
