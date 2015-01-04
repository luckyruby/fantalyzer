$('#projection_form').html("<%= escape_javascript(render 'form') %>")
$('#projection_player_id').select2
  width: 'resolve'
$('#projection_form').modal('show')
