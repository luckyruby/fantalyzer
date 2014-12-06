require 'open-uri'
desc "Loads Game Data off of yahoo"
task :load_games => :environment do
  start = Time.now
  puts "Start: #{start}"

  duration = Time.now - start
  puts "Duration: #{duration}"
end
