$("#games_<%= @player.id %>").html("<%= escape_javascript(render 'list') %>")
