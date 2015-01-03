class PlayerSearch
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :position, :user_id
  attr_reader :results

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def results
    players = Player.eager_load(:games, :salary, :statistic, :team).where("statistics.games_played > 0 and salaries.salary > 0 and salaries.user_id = ?", user_id).order("mean desc nulls last, salaries.salary desc")
    players = players.where("players.name ilike ?", "%#{name}%") if name.present?
    players = players.where(salaries: {position: position}) if position.present?
    players
  end

end
