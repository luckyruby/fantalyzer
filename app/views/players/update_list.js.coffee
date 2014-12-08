$('#players').html("<%= escape_javascript(render 'list') %>")
$('.line').sparkline 'html',
  type: 'line'
$('.discrete').sparkline 'html',
  type: 'discrete'
$('.box').sparkline 'html',
  type: 'box'
$('#games').empty()
