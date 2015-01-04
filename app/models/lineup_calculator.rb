class LineupCalculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :players
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
    stats = Player.eager_load(:statistic, :salary).where(id: players.reject(&:blank?))
    salary = stats.map{|i| i.salary.salary}.sum
    mean = stats.map(&:mean).sum
    last_5 = stats.map(&:last_5).sum
    "salary: #{salary}, mean: #{mean}, last_5: #{last_5}"
  end

end
