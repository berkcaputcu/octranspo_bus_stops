class CompareController < ApplicationController
	def select_stops
		@stops = Stop.all
		@json = Stop.all.to_gmaps4rails do |stop, marker|
			marker.json({ id: stop.id, name: stop.full_name })
		end
	end

	def select_routes
		@stops = []
		params[:stops].split(',').each do |stop_id|
			@stops << Stop.find(stop_id)
		end

	end

	def result
		route_ids = params[:routes]
		@stop_times = []
		to_map = []
		json_array = []

		marker_colors = ["FE7569", "008000"]
		color_ctr = -1
		
		route_ids.each do |stop_id, route_id|
			color_ctr += 1
			stop = Stop.find(stop_id)
			route = Route.find(route_id)

			json_array << stop.to_gmaps4rails

			stop_time = route.stop_times.find_or_create_by_stop_id(stop_id)
			stop_time.update_times

			stop_time.adjusted_times.each do |adjusted_time|
				unless adjusted_time.scheduled?
					json_array << adjusted_time.to_gmaps4rails do |bus, marker|
						marker.picture({
							:picture => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|#{marker_colors[color_ctr]}",
							:shadow_picture => "http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
							:width   => 21,
							:height  => 43,
							:marker_anchor => [10, 34],
							:shadow_width => "40",
							:shadow_height => "37",
							:shadow_anchor => [12, 35]
							})
					end
				end
			end

			@stop_times << stop_time
		end

		bus_route_id = nil


		json_array << to_map.to_gmaps4rails do |bus, marker|
			if !bus_route_id or bus_route_id != bus.route.id
				bus_route_id = bus.route.id
				
			end

		end
		
		temp = []
		json_array.each do |j|
			temp += JSON.parse(j)
		end
		@json = temp.to_json

	end
end
