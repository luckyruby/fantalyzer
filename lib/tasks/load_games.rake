require 'open-uri'
desc "Loads Game Data off of yahoo"
task :load_games => :environment do
  start = Time.now
  puts "Start: #{start}"
  today = start.to_date
  Player.all.each do |player|
    games = {}
    url = "http://sports.yahoo.com/nba/players/#{player.id}/gamelog/"
    puts "Scraping #{url}"
    doc = Nokogiri::HTML(open(url))
    game_log = doc.css('#mediasportsplayergamelog')
    dates = game_log.css('.date').map(&:text)
    dates.each_with_index do |date, index|
      date_obj = Date.parse(date) rescue nil
      date_obj -= 1.year if date_obj && date_obj > today
      games[index] = { game_date: date_obj }
    end

    opponents = game_log.css('.opponent').map(&:text)
    opponents.each_with_index {|opponent, i| games[i][:opponent] = opponent}

    scores = game_log.css('.score').map(&:text).reject(&:blank?)
    scores.each_with_index {|score, i| games[i][:score] = score}

    minutes = game_log.css('.minutes-played').map(&:text)
    minutes.each_with_index {|minute, i| games[i][:minutes] = minute}

    field_goals_made = game_log.css('.field-goals-made').map(&:text)
    field_goals_made.each_with_index {|field_goals, i| games[i][:field_goals_made] = field_goals}

    field_goals_attempted = game_log.css('.field-goals-attempted').map(&:text)
    field_goals_attempted.each_with_index {|field_goals, i| games[i][:field_goals_attempted] = field_goals}

    field_goal_percentages = game_log.css('.field-goal-percentage').map(&:text)
    field_goal_percentages.each_with_index {|percentage, i| games[i][:field_goal_percentage] = percentage}

    three_pt_made = game_log.css("[class~='3-point-shots-made']").map(&:text)
    three_pt_made.each_with_index {|three_pt, i| games[i][:three_points_made] = three_pt}

    three_pt_attempted = game_log.css("[class~='3-point-shots-attemped']").map(&:text)
    three_pt_attempted.each_with_index {|three_pt, i| games[i][:three_points_attempted] = three_pt}

    three_pt_percentages = game_log.css("[class~='3-point-percentage']").map(&:text)
    three_pt_percentages.each_with_index {|percentage, i| games[i][:three_point_percentage] = percentage}

    free_throws_made = game_log.css('.free-throws-made').map(&:text)
    free_throws_made.each_with_index {|free_throws, i| games[i][:free_throws_made] = free_throws}

    free_throws_attempted = game_log.css('.free-throws-attempted').map(&:text)
    free_throws_attempted.each_with_index {|free_throws, i| games[i][:free_throws_attempted] = free_throws}

    free_throw_percentages = game_log.css('.free-throw-percentage').map(&:text)
    free_throw_percentages.each_with_index {|percentage, i| games[i][:free_throw_percentage] = percentage}

    offensive_rebounds = game_log.css('.offensive-rebounds').map(&:text)
    offensive_rebounds.each_with_index {|rebound, i| games[i][:offensive_rebounds] = rebound}

    defensive_rebounds = game_log.css('.defensive-rebounds').map(&:text)
    defensive_rebounds.each_with_index {|rebound, i| games[i][:defensive_rebounds] = rebound}

    rebounds = game_log.css('.total-rebounds').map(&:text)
    rebounds.each_with_index {|rebound, i| games[i][:rebounds] = rebound}

    assists = game_log.css('.assists').map(&:text)
    assists.each_with_index {|assist, i| games[i][:assists] = assist}

    turnovers = game_log.css('.turnovers').map(&:text)
    turnovers.each_with_index {|turnover, i| games[i][:turnovers] = turnover}

    steals = game_log.css('.steals').map(&:text)
    steals.each_with_index {|steal, i| games[i][:steals] = steal}

    blocks = game_log.css('.blocked-shots').map(&:text)
    blocks.each_with_index {|block, i| games[i][:blocks] = block}

    fouls = game_log.css('.personal-fouls').map(&:text)
    fouls.each_with_index {|foul, i| games[i][:personal_fouls] = foul}

    points = game_log.css('.points-scored').map(&:text)
    points.each_with_index {|point, i| games[i][:points] = point}

    games.delete(0)
    games.values.each do |i|
      game = Game.where(player_id: player.id, game_date: i[:game_date]).first
      unless game
        player.games.create!(i)
      end
    end
    player.update({updated_at: Time.now})
    puts "Finished #{player.name}"
  end
  duration = Time.now - start
  puts "Duration: #{duration}"
end
