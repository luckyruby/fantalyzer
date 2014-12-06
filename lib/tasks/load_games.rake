require 'open-uri'
desc "Loads Game Data off of yahoo"
task :load_games => :environment do
  start = Time.now
  puts "Start: #{start}"
  today = start.to_date
  Player.all.each do |player|
    games = {}
    url = "http://sports.yahoo.com/nba/players/#{player.id}/gamelog/"
    #url = "http://sports.yahoo.com/nba/players/4203/gamelog/"
    puts "Scraping #{url}"
    doc = Nokogiri::HTML(open(url))
#    begin
      gamelog = doc.css('#mediasportsplayergamelog')
      dates = gamelog.css('.date').map(&:text)
      dates.each_with_index do |date, index|
        date_obj = Date.parse(date) rescue nil
        date_obj -= 1.year if date_obj && date_obj > today
        games[index] = { game_date: date_obj }
      end

      opponents = gamelog.css('.opponents').map(&:text)
      opponents.each_with_index {|opponent, i| games[i][:opponent] = opponent}

      scores = gamelog.css('.score').map(&:text).reject(&:blank?)
      scores.each_with_index {|score, i| games[i][:score] = score}

      minutes = gamelog.css('.minutes-played').map(&:text)
      minutes.each_with_index {|minute, i| games[i][:minutes] = minute}

      field_goals_made = gamelog.css('.field-goals-made').map(&:text)
      field_goals_made.each_with_index {|field_goals, i| games[i][:field_goals_made] = field_goals}

      field_goals_attempted = gamelog.css('.field-goals-attempted').map(&:text)
      field_goals_attempted.each_with_index {|field_goals, i| games[i][:field_goals_attempted] = field_goals}

      field_goal_percentages = gamelog.css('.field-goal-percentage').map(&:text)
      field_goal_percentages.each_with_index {|percentage, i| games[i][:field_goal_percentage] = percentage}

      three_pt_made = gamelog.css('nba-stat-type-11').map(&:text)
      three_pt_made.each_with_index {|three_pt, i| games[i][:three_points_made] = three_pt}

      three_pt_attempted = gamelog.css('nba-stat-type-10').map(&:text)
      three_pt_attempted.each_with_index {|three_pt, i| games[i][:three_points_attempted] = three_pt}

      three_pt_percentages = gamelog.css('nba-stat-type-12').map(&:text)
      three_pt_percentages.each_with_index {|percentage, i| games[i][:three_point_percentage] = percentage}

      free_throws_made = gamelog.css('.free-throws-made').map(&:text)
      free_throws_made.each_with_index {|free_throws, i| games[i][:free_throws_made] = free_throws}

      free_throws_attempted = gamelog.css('.free-throws-attempted').map(&:text)
      free_throws_attempted.each_with_index {|free_throws, i| games[i][:free_throws_attempted] = free_throws}

      free_throw_percentages = gamelog.css('.free-throw-percentage').map(&:text)
      free_throw_percentages.each_with_index {|percentage, i| games[i][:free_throw_percentage] = percentage}

      offensive_rebounds = gamelog.css('.offensive-rebounds').map(&:text)
      offensive_rebounds.each_with_index {|rebound, i| games[i][:offensive_rebounds] = rebound}

      defensive_rebounds = gamelog.css('.defensive-rebounds').map(&:text)
      defensive_rebounds.each_with_index {|rebound, i| games[i][:defensive_rebounds] = rebound}

      rebounds = gamelog.css('.total-rebounds').map(&:text)
      rebounds.each_with_index {|rebound, i| games[i][:rebounds] = rebound}

      assists = gamelog.css('.assists').map(&:text)
      assists.each_with_index {|assist, i| games[i][:assists] = assist}

      turnovers = gamelog.css('.turnovers').map(&:text)
      turnovers.each_with_index {|turnover, i| games[i][:turnovers] = turnover}

      steals = gamelog.css('.steals').map(&:text)
      steals.each_with_index {|steal, i| games[i][:steals] = steal}

      blocks = gamelog.css('.blocked-shots').map(&:text)
      blocks.each_with_index {|block, i| games[i][:blocks] = block}

      fouls = gamelog.css('.personal-fouls').map(&:text)
      fouls.each_with_index {|foul, i| games[i][:personal_fouls] = foul}

      points = gamelog.css('.points-scored').map(&:text)
      points.each_with_index {|point, i| games[i][:points] = point}

      games.delete(0)
      games.values.each {|i| player.games.create!(i)}
#      player.update(updated_at: Time.now)
      puts "Finished #{player.name}"
#    rescue
#      player.update(active: false)
#      next
#    end
  end
  duration = Time.now - start
  puts "Duration: #{duration}"
end
