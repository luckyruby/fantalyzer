desc "Updates player aggregates"
task :update_aggregates => :environment do
  start = Time.now
  puts "Start: #{start}"

  aggregates = Game.select("player_id, avg(fanduel), stddev(fanduel), count(*) games_played, stddev(fanduel)/avg(fanduel) cv").group("player_id").group_by(&:player_id)

  Player.all.each do |player|
    stats = aggregates[player.id]
    if stats.present?
      value = player.salary ? stats[0].avg / player.salary * 1000 : nil
      player.update({mean: stats[0].avg, std_dev: stats[0].stddev, games_played: stats[0].games_played, cv: stats[0].cv, value: value})
    end
  end

  duration = Time.now - start
  puts "Duration: #{duration}"
end
