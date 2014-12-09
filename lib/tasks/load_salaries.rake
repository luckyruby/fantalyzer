desc "Load player salaries"
task :load_salaries => :environment do
  start = Time.now
  puts "Start: #{start}"

  data = File.open("#{Rails.root}/db/data/fanduel.txt", &:readline)

  parsed_data = JSON.parse(data)
  parsed_data.values.each do |v|
    name = v[1]
    player = Player.where("UPPER(name) = ?", name.upcase).first
    if player
      player.update({salary: v[5]})
    end
  end

  duration = Time.now - start
  puts "Duration: #{duration}"
end
