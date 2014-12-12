class Player < ActiveRecord::Base
  self.primary_key = 'id'
  has_many :games, dependent: :destroy, autosave: true
  has_many :player_positions, dependent: :destroy, autosave: true
  has_many :positions, through: :player_positions

  validates :id, :first_name, :last_name, presence: true
  validates :id, uniqueness: true
  validates :last_name, uniqueness: { scope: :first_name }

  def name
    "#{first_name} #{last_name}"
  end

  def fantasy_points
    games.order("game_date").map(&:fanduel).join(",")
  end

  class << self
    def update_aggregates
      aggregates = Game.select("player_id, avg(fanduel), stddev(fanduel), count(*) games_played, stddev(fanduel)/avg(fanduel) cv, stddev(fanduel)/(|/ count(*))*1.96 confidence_interval").group("player_id").group_by(&:player_id)

      Player.all.each do |player|
        stats = aggregates[player.id]
        if stats.present?
          cost_per_point = (player.salary? && stats[0].avg > 0) ? player.salary / stats[0].avg : nil
          player.update({mean: stats[0].avg, std_dev: stats[0].stddev, games_played: stats[0].games_played, cv: stats[0].cv, cost_per_point: cost_per_point, confidence_interval: stats[0].confidence_interval})
        end
      end
    end

    def load_salaries(data)
      parsed_data = JSON.parse(data)
      Player.update_all(salary: nil)
      parsed_data.values.each do |v|
        name = v[1]
        if player = Player.where("UPPER(name) = ?", name.upcase).first
          player.update({position: v[0], salary: v[5]})
        end
      end
      Player.update_aggregates
    end
  end

end
