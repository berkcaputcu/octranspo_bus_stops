# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'CSV'

CSV.foreach('stops.txt', :headers => true) do |csv_obj|

	Stop.create(stop_id: csv_obj['stop_id'], stop_code: csv_obj['stop_code'], stop_name: csv_obj['stop_name'])

end