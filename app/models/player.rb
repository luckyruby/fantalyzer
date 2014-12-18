class Player < ActiveRecord::Base
  self.primary_key = 'id'
  has_many :games, dependent: :destroy, autosave: true
  has_many :player_positions, dependent: :destroy, autosave: true
  has_many :positions, through: :player_positions
  has_one :salary, dependent: :destroy, autosave: true
  has_one :statistic, dependent: :destroy, autosave: true

  delegate :mean, :std_dev, :cv, :max_fanduel, :confidence_interval, :games_played, :last_5, to: :statistic, allow_nil: true

  delegate :position, :status, :cost_per_point, to: :salary, allow_nil: true

  validates :id, :first_name, :last_name, presence: true
  validates :id, :name, uniqueness: true
  validates :last_name, uniqueness: { scope: :first_name }

  POSITIONS = %w(PG SG SF PF C)

  def name
    "#{first_name} #{last_name}"
  end

  def fantasy_points
    games.order("game_date").map(&:fanduel).join(",")
  end

  class << self
    def update_statistics
      aggregates = Game.select("player_id, avg(fanduel), stddev(fanduel), count(*) games_played, stddev(fanduel)/avg(fanduel) cv, stddev(fanduel)/(|/ count(*))*1.96 confidence_interval, max(fanduel) as max_fanduel").group("player_id").group_by(&:player_id)

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
          statistic.save
        end
      end
    end

    def load_salaries(data, user)
      parsed_data = JSON.parse(data)
      Salary.delete_all(user_id: user.id)
      parsed_data.values.each do |v|
        name = v[1]
        status = case v[12]
        when "OUT" then 'out'
        when "GTD" then 'gtd'
        else
          'active'
        end
        if player = Player.where("UPPER(name) = ?", name.upcase).first
          salary = v[5].to_i
          cost_per_point = (player.mean && player.mean > 0) ? salary / player.mean : nil
          user.salaries.create!(player_id: player.id, position: v[0], salary: v[5], cost_per_point: cost_per_point, status: status)
        end
      end
    end
  end

end
