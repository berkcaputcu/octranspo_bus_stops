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

		route_ids.each do |stop_id, route_id|

			stop = Stop.find(stop_id)
			route = Route.find(route_id)

			stop_time = route.stop_times.find_or_create_by_stop_id(stop_id)
			stop_time.update_times

			stop_time.adjusted_times.each do |bus|
				unless bus.scheduled?
					to_map << bus
				end
			end

			@stop_times << stop_time
		end

		bus_route_id = nil
		marker_colors = ["FE7569", "008000"]
		color_ctr = -1
		@json = to_map.to_gmaps4rails do |bus, marker|
			if !bus_route_id or bus_route_id != bus.route.id
				bus_route_id = bus.route.id
				color_ctr += 1
			end
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
