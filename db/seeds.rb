# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Position.all.blank?
  %w(PG SG G SF PF F C).each {|position| Position.create!(name: position)}
end

if User.all.blank?
  User.create!(first_name: 'Ken', last_name: 'Lin', email: 'klin@luckyruby.com', password: 'password', admin: true)
  User.create!(first_name: 'Jeff', last_name: 'Lin', email: 'chopinique21@gmail.com', password: 'password')
end
