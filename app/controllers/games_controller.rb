class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.js {
        @player = Player.find(params[:id])
        @games = @player.games.order("game_date DESC") if @player
        render template: 'games/update_list'
      }
    end
  end
end
