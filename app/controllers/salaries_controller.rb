class SalariesController < ApplicationController
  before_action :authenticate_user!

  def new
    @salary_select = 'active'
  end

  def load
    Player.load_salaries(params[:data], current_user)
    redirect_to players_path, notice: 'Successfully loaded salary data'
  rescue => e
    logger.error ([e.message] + e.backtrace).join("\n")
    flash[:error] = "Processing Error. #{e.message}"
    redirect_to new_salary_path
  end
end
