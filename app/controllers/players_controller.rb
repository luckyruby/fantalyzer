class PlayersController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html {
        @player_select = 'active'
        @search = PlayerSearch.new
        }
      format.js {
        @search = PlayerSearch.new(params[:search])
        @search.user_id = current_user.id
        @players = @search.results
        render template: 'players/update_list'
      }
    end
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
