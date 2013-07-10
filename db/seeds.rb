# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'CSV'
require 'open-uri'

CSV.foreach(open('http://dl.dropboxusercontent.com/u/3243565/stops.txt'), :headers => true) do |csv_obj|

	Stop.create(code: csv_obj['stop_code'], name: csv_obj['stop_name'], lat: csv_obj['stop_lat'], long: csv_obj['stop_lon'])

end