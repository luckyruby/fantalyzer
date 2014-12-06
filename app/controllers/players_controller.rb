class PlayersController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.js {
        @players = Player.where(["first_name ILIKE ? OR last_name ILIKE ? OR first_name || ' ' || last_name ILIKE ? OR last_name || ' ' || first_name ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%"]) if params[:search].present?
        render template: 'players/update_list'
      }
    end
  end
end
