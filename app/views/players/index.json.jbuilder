json.players @players do |p|
  json.id p.id
  json.name p.name
  json.position p.position
  json.salary p.salary.salary
  json.last_5 p.last_5
  json.mean p.mean
  json.cv p.cv
  json.std_dev p.std_dev
  json.confidence_interval p.confidence_interval
  json.cost_per_point p.cost_per_point
  json.games_played p.games_played
end
