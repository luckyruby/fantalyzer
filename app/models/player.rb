class Player < ActiveRecord::Base
  self.primary_key = 'id'
  belongs_to :team
  has_many :games, dependent: :destroy, autosave: true
  has_many :player_positions, dependent: :destroy, autosave: true
  has_many :positions, through: :player_positions
  has_one :salary, -> { where(user_id: User.current.id)}, dependent: :destroy, autosave: true
  has_one :statistic, dependent: :destroy, autosave: true
  has_one :projection, -> { where(user_id: User.current.id)}, dependent: :destroy, autosave: true

  delegate :mean, :std_dev, :cv, :max_fanduel, :confidence_interval, :games_played, :last_5, :sparkline, to: :statistic, allow_nil: true

  delegate :position, :status, :cost_per_point, to: :salary, allow_nil: true

  validates :id, :first_name, :last_name, presence: true
  validates :id, :name, uniqueness: true
  validates :last_name, uniqueness: { scope: :first_name }

  POSITIONS = %w(PG SG SF PF C)

  def fantasy_points
    games.order("game_date").map(&:fanduel).join(",")
  end

  def actual(date)
    game = games.where(game_date: date).first
    game ? game.fanduel : 0
  end

  def last_5_on(date)
    games.where("games.game_date < ?",date).order("game_date DESC").limit(5).map(&:fanduel).sum / 5.0
  end

  def projected
    projection.try(:points) || last_5 || 0
  end

  def last_7_max
    games.order("game_date DESC").limit(7).map(&:fanduel).max
  end

  def proj_cost_per_point
    salary.salary / projected
  end

  class << self
    def update_statistics(date=Date.today)
      aggregates = Game.select("player_id, avg(fanduel), stddev(fanduel), count(*) games_played, case when avg(fanduel) = 0 then NULL else (stddev(fanduel)/avg(fanduel)) end as cv, case when count(*) = 0 then NULL else (stddev(fanduel)/(|/ count(*))*1.96) end as confidence_interval, max(fanduel) as max_fanduel").where("game_date <= ?", date).group("player_id").group_by(&:player_id)

      Player.all.each do |player|
        stats = aggregates[player.id]
        if stats.present?
          statistic = Statistic.find_or_initialize_by(player_id: player.id)
          statistic.mean = stats[0].avg
          statistic.std_dev = stats[0].stddev
          statistic.games_played = stats[0].games_played
          statistic.cv = stats[0].cv
          statistic.confidence_interval = stats[0].confidence_interval
          statistic.max_fanduel = stats[0].max_fanduel
          statistic.last_5 = player.games.order("game_date DESC").limit(5).map(&:fanduel).sum / 5.0
          statistic.sparkline = player.games.order("game_date").map(&:fanduel).join(",")
          statistic.save
        end
      end
    end
  end

end
