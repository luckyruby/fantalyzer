class ProjectionsController < ApplicationController
  before_action :authenticate_user!

  def index
    load_projections
  end

  def new
    respond_to do |format|
      format.js {
        @projection = Projection.new
        render_form
      }
    end
  end

  def create
    respond_to do |format|
      format.js {
        @projection = Projection.new(safe_params)
        @projection.user_id = current_user.id
        if @projection.save
          render_list
        else
          render_form
        end
      }
    end
  end

  def edit
    respond_to do |format|
      format.js {
        find_projection
        render_form
      }
    end
  end

  def update
    respond_to do |format|
      format.js {
        find_projection
        if @projection.update(safe_params)
          render_list
        else
          render_form
        end
      }
    end
  end

  def destroy
    respond_to do |format|
      format.js {
        find_projection
        @projection.destroy
        render_list
      }
    end
  end

  private

  def load_players
    @players = Player.all.order(:name)
  end

  def find_projection
    @projection = Projection.find(params[:id])
  end

  def load_projections
    @projections = current_user.projections.order("created_at DESC")
  end

  def render_list
    load_projections
    render template: 'projections/update_list'
  end

  def render_form
    load_players
    render template: 'projections/display_form'
  end

  def safe_params
    params.require(:projection).permit(:points, :player_id)
  end
end
