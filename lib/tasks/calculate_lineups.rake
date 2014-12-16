desc "Calculate Lineups"
task calculate_lineups: :environment do
  start = Time.now
  puts "Start: #{start}"
  require 'csv'

  def qualifying_salaries(combos)
    salaries = []

    salaries
  end

  user = User.where(email: 'klin@luckyruby.com').first
  salaries = user.salaries.group_by(&:position)
  combos = {}
  combos_by_salary = {}
  salaries.each do |k,v|
    num = (k == 'C' ? 1 : 2)
    combos[k] = v.combination(num).map {|p| p.map(&:salary).sum}.uniq.sort.reverse
    combos_by_salary[k] = v.combination(num).map {|p| [p.map {|i| i.player.name}, p.map(&:salary).sum, p.map {|i| i.player.mean_last5}.sum.to_f]}.group_by {|i| i[1]}
  end
  combos_by_salary.each do |position,salaries|
    salaries.each do |salary,players|
      combos_by_salary[position][salary] = players.sort{|a,b| a[2] <=> b[2]}.last
    end
  end

  positions = %w(PG SG SF PF C)

  lineups = []
  combos['PG'].each do |pg|
    combos['SG'].each do |sg|
      combos['SF'].each do |sf|
        next if pg + sg + sf > 60000
        combos['PF'].each do |pf|
          next if pg + sg + sf + pf > 60000
          combos['C'].each do |c|
            sum = pg + sg + sf + pf + c
            next if sum > 60000 || sum < 59000
            salaries = [pg, sg, sf, pf, c]
            players = {}
            points = positions.each_with_index.map do |p,i|
              salary = combos_by_salary[p][salaries[i]]
              players[p] = salary[0].join(", ")
              salary[2]
            end
            next if points.sum < 260
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
  end
  lineups.sort! {|a,b| a[:points] <=> b[:points]}
  puts lineups.length
  puts lineups.last(50).reverse

  duration = Time.now - start
  puts "Duration: #{duration}"
end
