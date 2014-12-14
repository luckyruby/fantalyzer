desc "Updates Statistics"
task update_statistics: :environment do
  start = Time.now
  puts "Start: #{start}"

  Player.update_statistics

  duration = Time.now - start
  puts "Duration: #{duration}"
end
