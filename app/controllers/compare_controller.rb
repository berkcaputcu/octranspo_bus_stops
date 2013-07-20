class CompareController < ApplicationController
	def select_stops
		@stops = Stop.all
		@json = Stop.all.to_gmaps4rails do |stop, marker|
			marker.json({ id: stop.id, name: stop.full_name })
		end
	end

	def result

		if params[:routes].blank?
			redirect_to root_path
			return
		end

		route_ids = params[:routes]
		@stop_times = []
		@bus_times = []
		json_array = []

		@marker_colors = ["FE7569", "008000", "FFA500", "0000FF", "00FF00", "FFFF00", "800000" , "808000", "00FFFF", "ADD8E6"]
		color_ctr = -1
		
		route_ids.each do |stop_id, route_id|
			color_ctr += 1
			stop = Stop.find(stop_id)
			route = Route.find(route_id)

			json_array << stop.to_gmaps4rails

			stop_time = route.stop_times.find_or_create_by_stop_id(stop_id)
			stop_time.update_times

			if user_signed_in?
				current_user.log stop_time
			end

			stop_time.adjusted_times.each do |adjusted_time|
				unless adjusted_time.scheduled?
					@bus_times << adjusted_time

					json_array << adjusted_time.to_gmaps4rails do |bus, marker|
						marker.picture({
							:picture => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=#{bus.route.no}|#{@marker_colors[color_ctr]}",
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

		@bus_times.sort! { |bus_time1, bus_time2| bus_time1.time_left <=> bus_time2.time_left }

		temp = []
		json_array.each do |j|
			temp += JSON.parse(j)
		end
		@json = temp.to_json

		if session[:refresh].blank?
			session[:refresh] = false
		elsif session[:refresh]
			if session[:refresh_count] > 1
				session[:refresh_count] -= 1
			else
				session[:refresh_count] = 0
				session[:refresh] = false
			end
		end

	end

	def refresh
		session[:refresh] = true
		session[:refresh_count] = 10

		respond_to do |format|
			format.js { head :no_content }
		end
	end

end
