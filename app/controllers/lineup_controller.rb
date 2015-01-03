class LineupController < ApplicationController
  before_action :authenticate_user!

  def calculator
    respond_to do |format|
      format.html {
        @lineup_select = 'active'
        @calculator = LineupCalculator.new
        @players = Player.order(:name)
      }
      format.js {
        @calculator = LineupCalculator.new(params[:calculator])
        render js: "alert('#{@calculator.results}')"
      }
    end
  end
end
