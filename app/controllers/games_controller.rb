class GamesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.js {
        @player = Player.find(params[:id])
        @games = @player.games if @player
        render template: 'games/update_list'
      }
    end
  end
end
