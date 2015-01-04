desc "Calculate Lineups"
task :calculate_lineups, [:max_points, :top_n, :optimize_by, :actual_date] => :environment do |t,args|
  start = Time.now
  puts "Start: #{start}"

  user = User.where(email: 'klin@luckyruby.com').first
  User.current = user
  salaries = user.salaries.active.group_by(&:position)
  combos = {}
  combos_by_salary = {}
  actual_date = Date.parse(args.actual_date) rescue nil

  salaries.each do |k,v|
    num = (k == 'C' ? 1 : 2)
    combinations = v.combination(num)
    combos[k] = combinations.map {|p| p.map(&:salary).sum}.uniq.sort.reverse
    combos_by_salary[k] = if actual_date
      combinations.map {|p| [p.map {|i| i.player.name}, p.map(&:salary).sum, p.map {|i| i.player.send(args.optimize_by, actual_date) || 0}.sum.to_f, p.map {|i| i.player.actual(actual_date) || 0}.sum.to_f]}.group_by {|i| i[1]}
    else
      combinations.map {|p| [p.map {|i| i.player.name}, p.map(&:salary).sum, p.map {|i| i.player.send(args.optimize_by) || 0}.sum.to_f]}.group_by {|i| i[1]}
    end
  end

  #find highest scoring representative for each salary
  combos_by_salary.each do |position,salaries|
    salaries.each do |salary,players|
      combos_by_salary[position][salary] = players.sort{|a,b| a[2] <=> b[2]}.last
    end
  end

  positions = %w(PG SG SF PF C)

  top_lineups = []

  max_points = args.max_points.to_f

  combos['C'].each do |c|
    lineups = []
    combos['SG'].each do |sg|
      combos['SF'].each do |sf|
        next if c + sg + sf > 46000
        combos['PF'].each do |pf|
          next if c + sg + sf + pf > 53000
          combos['PG'].each do |pg|
            sum = c + sg + sf + pf + pg
            next if sum > 60000 || sum < 59000
            salaries = [pg, sg, sf, pf, c]
            players = {}
            points = []
            #actual = []
            positions.each_with_index do |p,i|
              salary = combos_by_salary[p][salaries[i]]
              players[p] = salary[0].join(", ")
              points << salary[2]
              #actual << salary[3]
            end
            next if points.sum < max_points
            lineup = {
              pg: players['PG'],
              sg: players['SG'],
              sf: players['SF'],
              pf: players['PF'],
              c: players['C'],
              points: points.sum.round(2)
            }
            lineups << lineup
          end
        end
      end
    end
    lineups.sort! {|a,b| a[:points] <=> b[:points]}
    top_n = (args.top_n || 10).to_i
    top_lineups << lineups.last(top_n).reverse
  end
  puts "\n\n\nTOP LINEUPS"
  top_lineups.each do |t|
    puts "#{t.join("\n")}\n\n"
  end

  duration = Time.now - start
  puts "Duration: #{duration}"
end
