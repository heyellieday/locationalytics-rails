# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Location.create({name: "Zone 1", city: "Chicago", address: "Front 1871 auditorium", bounds: {"minX"=>-0.5, "maxX"=>50, "minY"=>-0.5, "maxY"=>44}})
Location.create({name: "Zone 2", city: "Chicago", address: "Back 1871 auditorium", bounds: {"minX"=>-0.5, "maxX"=>50, "minY"=>47, "maxY"=>60}})
