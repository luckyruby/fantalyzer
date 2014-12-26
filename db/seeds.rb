# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.all.blank?
  User.create!(first_name: 'Ken', last_name: 'Lin', email: 'klin@luckyruby.com', password: 'password', admin: true)
  User.create!(first_name: 'Jeff', last_name: 'Lin', email: 'chopinique21@gmail.com', password: 'password')
end

if Team.all.blank?
  Team.create!(name: 'Boston Celtics', abbreviation: 'bos', conference: 'Eastern', division: 'Atlantic', short_code: 'bos')
  Team.create!(name: 'Brooklyn Nets', abbreviation: 'bro', conference: 'Eastern', division: 'Atlantic', short_code: 'bkn')
  Team.create!(name: 'New York Knicks', abbreviation: 'nyk', conference: 'Eastern', division: 'Atlantic', short_code: 'ny')
  Team.create!(name: 'Philadelphia 76ers', abbreviation: 'phi', conference: 'Eastern', division: 'Atlantic', short_code: 'phi')
  Team.create!(name: 'Toronto Raptors', abbreviation: 'tor', conference: 'Eastern', division: 'Atlantic', short_code: 'tor')
  Team.create!(name: 'Chicago Bulls', abbreviation: 'chi', conference: 'Eastern', division: 'Central', short_code: 'chi')
  Team.create!(name: 'Cleveland Cavaliers', abbreviation: 'cle', conference: 'Eastern', division: 'Central', short_code: 'cle')
  Team.create!(name: 'Detroit Pistons', abbreviation: 'det', conference: 'Eastern', division: 'Central', short_code: 'det')
  Team.create!(name: 'Indiana Pacers', abbreviation: 'ind', conference: 'Eastern', division: 'Central', short_code: 'ind')
  Team.create!(name: 'Milwaukee Bucks', abbreviation: 'mil', conference: 'Eastern', division: 'Central', short_code: 'mil')
  Team.create!(name: 'Atlanta Hawks', abbreviation: 'atl', conference: 'Eastern', division: 'Southeast', short_code: 'atl')
  Team.create!(name: 'Miami Heat', abbreviation: 'mia', conference: 'Eastern', division: 'Southeast', short_code: 'mia')
  Team.create!(name: 'Orlando Magic', abbreviation: 'orl', conference: 'Eastern', division: 'Southeast', short_code: 'orl')
  Team.create!(name: 'Washington Wizards', abbreviation: 'was', conference: 'Eastern', division: 'Southeast', short_code: 'was')
  Team.create!(name: 'Charlotte Hornets', abbreviation: 'cha', conference: 'Eastern', division: 'Southeast', short_code: 'cha')
  Team.create!(name: 'Golden State Warriors', abbreviation: 'gsw', conference: 'Western', division: 'Pacific', short_code: 'gs')
  Team.create!(name: 'Los Angeles Clippers', abbreviation: 'lac', conference: 'Western', division: 'Pacific', short_code: 'lac')
  Team.create!(name: 'Los Angeles Lakers', abbreviation: 'lal', conference: 'Western', division: 'Pacific', short_code: 'lal')
  Team.create!(name: 'Phoenix Suns', abbreviation: 'pho', conference: 'Western', division: 'Pacific', short_code: 'pho')
  Team.create!(name: 'Sacramento Kings', abbreviation: 'sac', conference: 'Western', division: 'Pacific', short_code: 'sac')
  Team.create!(name: 'New Orleans Pelicans', abbreviation: 'nor', conference: 'Western', division: 'Southwest', short_code: 'no')
  Team.create!(name: 'Dallas Mavericks', abbreviation: 'dal', conference: 'Western', division: 'Southwest', short_code: 'dal')
  Team.create!(name: 'Houston Rockets', abbreviation: 'hou', conference: 'Western', division: 'Southwest', short_code: 'hou')
  Team.create!(name: 'San Antonio Spurs', abbreviation: 'sas', conference: 'Western', division: 'Southwest', short_code: 'sa')
  Team.create!(name: 'Memphis Grizzlies', abbreviation: 'mem', conference: 'Western', division: 'Southwest', short_code: 'mem')
  Team.create!(name: 'Denver Nuggets', abbreviation: 'den', conference: 'Western', division: 'Northwest', short_code: 'den')
  Team.create!(name: 'Minnesota Timberwolves', abbreviation: 'min', conference: 'Western', division: 'Northwest', short_code: 'min')
  Team.create!(name: 'Portland Trail Blazers', abbreviation: 'por', conference: 'Western', division: 'Northwest', short_code: 'por')
  Team.create!(name: 'Oklahoma City Thunder', abbreviation: 'okc', conference: 'Western', division: 'Northwest', short_code: 'okc')
  Team.create!(name: 'Utah Jazz', abbreviation: 'uth', conference: 'Western', division: 'Northwest', short_code: 'uta')
end
