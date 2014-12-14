$("#games_<%= @player.id %>").html("<%= escape_javascript(render 'list') %>")
$("#games_<%= @player.id %>").modal('show')
