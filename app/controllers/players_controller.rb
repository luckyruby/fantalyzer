class PlayersController < ApplicationController
  def index
    respond_to do |format|
      format.html { @search = PlayerSearch.new }
      format.js {
        @search = PlayerSearch.new(params[:search])
        @players = @search.results
        render template: 'players/update_list'
      }
    end
  end
end
