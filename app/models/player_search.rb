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
    players = Player.eager_load(:games, :positions).order("mean desc nulls last")
    players.where("name ilike ?", "%#{name}%") if name.present?
    players.where(positions: { name: position }) if position.present?
  end

end
