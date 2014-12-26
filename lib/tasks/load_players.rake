require 'open-uri'

desc "Loads Player Data off of yahoo"
task load_players: :environment do
  start = Time.now
  puts "Start: #{start}"

  ActiveRecord::Base.connection.execute("TRUNCATE players restart identity")
  teams = Team.all.group_by(&:abbreviation)
  %w(PG SG G SF PF F C).each do |position|
    url = "http://sports.yahoo.com/nba/players?type=position&c=NBA&pos=#{position}"
    puts "Scraping #{url}"
    doc = Nokogiri::HTML(open(url))
    doc.css(".ysprow1, .ysprow2").each do |row|
      begin
        td_a = row.css('td a')
        name = td_a.first.text
        split_name = name.split(" ")
        team = teams[td_a.last['href'].split("/").last.downcase].first
        id = td_a.first['href'].split("/").last.to_i
        player = Player.create!(id: id, name: name, first_name: split_name[0], last_name: split_name[1], team_id: team.id)
      rescue
        next
      end
    end
  end

  duration = Time.now - start
  puts "Duration: #{duration}"
end
