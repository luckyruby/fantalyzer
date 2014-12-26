class GameScore < ActiveRecord::Base

  validates :game_date, :winner, :loser, :winner_points, :loser_points, :home, presence: true
end
