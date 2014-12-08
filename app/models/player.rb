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

  def mean
    result = Game.select("avg(fanduel)").where(player_id: self.id).load
    result.first.avg
  end

  def game_count
    games.length
  end

  def fantasy_points
    games.order("game_date").map(&:fanduel).join(",")
  end

  def std_dev
    result = Game.select("stddev(fanduel)").where(player_id: self.id).load
    result.first.stddev
  end
end
