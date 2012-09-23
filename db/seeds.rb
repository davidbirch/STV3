# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"

# import the data for regions
CSV.open("db/seed data/regions.csv", "r").each do |row|
  Region.create(
    :region_name => row[0]
  )
end

# import the data for sports
CSV.open("db/seed data/sports.csv", "r").each do |row|
  Sport.create(
    :sport_name => row[0]
  )
end

# import the white sport names
CSV.open("db/seed data/ruleset - white sports.csv", "r").each do |row|
  Rule.create(
    :rule_type => row[2],
    :value => row[0],
    :sport_name => row[1],
    :sport_id => Sport.where("sport_name = ?", row[1]).first["id"]
    
  )
end

# import the white sport keywords
CSV.open("db/seed data/ruleset - white keywords.csv", "r").each do |row|
  Rule.create(
    :rule_type => row[2],
    :value => row[0],
    :sport_name => row[1],
    :sport_id => Sport.where("sport_name = ?", row[1]).first["id"]
  )
end
