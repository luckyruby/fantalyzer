require 'open-uri'
desc "Loads Player Data off of yahoo"
task :load_players => :environment do
  start = Time.now
  puts "Start: #{start}"

  ('a'..'z').each do |letter|
    url = "http://sports.yahoo.com/nba/players?type=lastname&query=#{letter}"
    puts "Scraping #{url}"
    doc = Nokogiri::HTML(open(url))
    doc.css(".ysprow1, .ysprow2").each do |row|
      begin
        name = row.at_css('td a').text.split(" ")
      rescue
        next
      end
      yahoo_id = row.at_css('td a')['href'].split("/").last
      Player.where(yahoo_id: yahoo_id).first_or_create do |player|
        player.first_name = name.first
        player.last_name = name.last
        puts "Created #{name.join(" ")}"
      end
    end
    sleep 2
  end

  duration = Time.now - start
  puts "Duration: #{duration}"
end
