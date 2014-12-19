class PlayersController < ApplicationController
  before_action :authenticate_user!, except: [:games]

  def index
    @player_select = 'active'
    @search = PlayerSearch.new
    @search.user_id = current_user.id
    @players = @search.results
  end

  def games
    @games = Game.all
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
