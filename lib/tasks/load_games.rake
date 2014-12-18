require 'celluloid/io'
require 'http'

class HttpFetcher
  include Celluloid::IO

  def fetch(url, proxy=nil)
    if proxy
      HTTP.via(proxy, 3128).get(url, socket_class: Celluloid::IO::TCPSocket)
    else
      HTTP.get(url, socket_class: Celluloid::IO::TCPSocket)
    end
  end
end

desc "Loads Game Data"
task :load_games, [:source] => :environment do |t,args|
  start = Time.now
  puts "Start: #{start}"
  today = start.to_date

  columns = [:player_id, :game_date, :opponent, :score, :minutes, :field_goals_made, :field_goals_attempted, :field_goal_percentage, :three_points_made, :three_points_attempted, :three_point_percentage, :free_throws_made, :free_throws_attempted, :free_throw_percentage, :offensive_rebounds, :defensive_rebounds, :rebounds, :assists, :turnovers, :steals, :blocks, :personal_fouls, :points, :fanduel]
  values = []

  fetcher = HttpFetcher.new
  if args.source == 'luckyruby'
    response = fetcher.future.fetch('http://fantasy.luckyruby.com/players/games')
    games = JSON.parse(response.value.to_s)
    games.each do |g|
      values << [g["player_id"], g["game_date"], g["opponent"], g["score"], g["minutes"], g["field_goals_made"], g["field_goals_attempted"], g["field_goal_percentage"], g["three_points_made"], g["three_points_attempted"], g["three_point_percentage"], g["free_throws_made"], g["free_throws_attempted"], g["free_throw_percentage"], g["offensive_rebounds"], g["defensive_rebounds"], g["rebounds"], g["assists"], g["turnovers"], g["steals"], g["blocks"], g["personal_fouls"], g["points"], g["fanduel"]]
    end
  else #grab data off yahoo
    proxies = %w(162.217.144.93 199.180.253.113 199.167.195.129) + [nil]

    Player.all.in_groups_of(4).each do |group|
      futures = group.compact.each_with_index.map do |player, proxy|
        url = "http://sports.yahoo.com/nba/players/#{player.id}/gamelog/"
        puts "#{player.name} -- GET to #{url} via #{proxies[proxy] || 'self'}"
        [player, fetcher.future.fetch(url, proxies[proxy])]
      end
      futures.each do |player, future|
        games = {}
        doc = Nokogiri::HTML(future.value.to_s)
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
        minutes.each_with_index do |minute, i|
          split_minute = minute.split(":")
          games[i][:minutes] = (split_minute[0].to_i + split_minute[1].to_i/60.0).round(2)
        end

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
          i[:fanduel] = i[:points].to_i + i[:rebounds].to_i * BigDecimal.new('1.2') + i[:assists].to_i * BigDecimal.new('1.5') + i[:blocks].to_i * 2 + i[:steals].to_i * 2 - i[:turnovers].to_i
          values << [player.id, i[:game_date], i[:opponent], i[:score], i[:minutes], i[:field_goals_made], i[:field_goals_attempted], i[:field_goal_percentage], i[:three_points_made], i[:three_points_attempted], i[:three_point_percentage], i[:free_throws_made], i[:free_throws_attempted], i[:free_throw_percentage], i[:offensive_rebounds], i[:defensive_rebounds], i[:rebounds], i[:assists], i[:turnovers], i[:steals], i[:blocks], i[:personal_fouls], i[:points], i[:fanduel]]
        end
      end
      sleep 1
    end
  end
  ActiveRecord::Base.connection.execute("TRUNCATE games restart identity")
  Game.import columns, values, validate: false
  Player.update_statistics
  duration = Time.now - start
  puts "Duration: #{duration}"
end
