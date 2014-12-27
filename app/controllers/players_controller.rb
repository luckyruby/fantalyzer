class PlayersController < ApplicationController
  before_action :authenticate_user!, except: [:games]

  def index
    respond_to do |format|
      format.html {
        @player_select = 'active'
        @search = PlayerSearch.new
        @search.user_id = current_user.id
        @players = @search.results
        @games = Game.where(player_id: @players.map(&:id)).order("game_date").group_by(&:player_id)
      }
      format.json {
        @search = PlayerSearch.new
        @search.user_id = current_user.id
        @players = @search.results
      }
    end
  end

  def games
    until_date = Date.parse(params[:until]) rescue nil
    @games = until_date ? Game.where("game_date <= ?", until_date) : Game.all
    render json: @games
  end

  def salaries
    @salary_select = 'active'
  end

  def load_salaries
    Player.load_salaries(params[:data], current_user)
    redirect_to players_path, notice: 'Successfully loaded salary data'
  rescue => e
    logger.error ([e.message] + e.backtrace).join("\n")
    flash[:error] = "Processing Error. #{e.message}"
    redirect_to salaries_players_path
  end
end
