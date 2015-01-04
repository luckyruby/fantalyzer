class PlayerSearch
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :position
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
    players = Player.eager_load(:salary, :statistic, :team, :projection).where("statistics.games_played > 0 and salaries.salary > 0").order("mean desc nulls last, salaries.salary desc")
    players
  end

end
