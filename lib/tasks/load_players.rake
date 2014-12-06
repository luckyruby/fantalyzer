require 'open-uri'
desc "Loads Player Data off of yahoo"
task :load_players => :environment do
  start = Time.now
  puts "Start: #{start}"

  %w(PG SG G SF PF F C).each do |position|
    pos = Position.where(name: position).first
    url = "http://sports.yahoo.com/nba/players?type=position&c=NBA&pos=#{position}"
    puts "Scraping #{url}"
    doc = Nokogiri::HTML(open(url))
    doc.css(".ysprow1, .ysprow2").each do |row|
      begin
        name = row.at_css('td a').text.split(" ")
        id = row.at_css('td a')['href'].split("/").last.to_i
        player = Player.where(id: id).first_or_create do |player|
          player.first_name = name.first
          player.last_name = name.last
          puts "Created #{name.join(" ")}"
        end
        PlayerPosition.where(player_id: player.id, position_id: pos.id).first_or_create
      rescue
        next
      end
    end
    sleep 2
  end

  duration = Time.now - start
  puts "Duration: #{duration}"
end
