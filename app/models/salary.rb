class Salary < ActiveRecord::Base
  require 'csv'
  
  belongs_to :user
  belongs_to :player
  has_one :statistic, through: :player

  validates :user, :player, :position, :salary, presence: true

  scope :active, -> {where status: 'active'}
  scope :productive, -> {joins(:statistic).where("statistics.last_5 > 10")}


  def self.load(data, user)
    missing_players = []
    Salary.delete_all(user_id: user.id)
    CSV.parse(data, headers: true) do |row|
      position = row[1]
      first_name = row[2]
      last_name = row[3]
      name = first_name + ' ' + last_name
      status = case row[10]
      when "OUT","O" then 'out'
      when "GTD" then 'gtd'
      when "" then 'active'
      else
        'unknown'
      end
      salary = row[6].to_i
      if player = Player.where("UPPER(name) = ?", name.upcase).first
        cost_per_point = (player.mean && player.mean > 0) ? salary / player.mean : nil
        user.salaries.create!(player_id: player.id, position: position, salary: salary, cost_per_point: cost_per_point, status: status)
      else
        missing_players << name
      end
    end
    puts "MISSING PLAYERS: #{missing_players.join(", ")}" if missing_players.present?
  end
end
