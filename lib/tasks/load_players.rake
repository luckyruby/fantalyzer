require 'open-uri'

desc "Loads Player Data off of yahoo"
task load_players: :environment do
  start = Time.now
  puts "Start: #{start}"

  ActiveRecord::Base.connection.execute("TRUNCATE players restart identity")
  %w(PG SG G SF PF F C).each do |position|
    pos = Position.where(name: position).first
    url = "http://sports.yahoo.com/nba/players?type=position&c=NBA&pos=#{position}"
    puts "Scraping #{url}"
    doc = Nokogiri::HTML(open(url))
    doc.css(".ysprow1, .ysprow2").each do |row|
      begin
        name = row.at_css('td a').text
        split_name = name.split(" ")
        id = row.at_css('td a')['href'].split("/").last.to_i
        player = Player.create!(id: id, name: name, first_name: split_name[0], last_name: split_name[1])
        PlayerPosition.where(player_id: player.id, position_id: pos.id).first_or_create
      rescue
        next
      end
    end
  end

  duration = Time.now - start
  puts "Duration: #{duration}"
end
