$('#players').html("<%= escape_javascript(render 'list') %>")
$('.line').sparkline 'html',
  type: 'line'
$('.box').sparkline 'html',
  type: 'box'
$('#games').empty()
