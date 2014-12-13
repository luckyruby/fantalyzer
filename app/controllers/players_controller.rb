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
        @players = @search.results
        render template: 'players/update_list'
      }
    end
  end

  def salaries
    @salary_select = 'active'
  end

  def load_salaries
    Player.load_salaries(params[:data])
    redirect_to players_path, notice: 'Successfully loaded salary data'
  rescue => e
    flash[:error] = "Processing Error. #{e.message}"
    redirect_to salaries_players_path
  end
end
