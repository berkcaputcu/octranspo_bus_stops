class CompareController < ApplicationController
	def select_stops
		@stops = Stop.all
		@json = Stop.all.to_gmaps4rails do |stop|
			"\"id\": \"#{stop.id}\", \"name\": \"#{stop.full_name}\""
		end
	end

	def select_routes
		@stop1 = Stop.find(params[:stop1])
		@stop2 = Stop.find(params[:stop2])

		@routes2=[]

		if @stop1.expired?
			response1 = Nokogiri::HTML(RestClient.post(
				ENV['GetRouteSummaryForStop'],
				{ :apiKey => ENV['apiKey'],
					:appID => ENV['appID'],
					:stopNo => @stop1.code
					}))

			@stop1.refreshed

			response1.xpath("//route").each do |route|

				r_no = route.at("routeno").content.to_s
				r_direction = route.at("direction").content.to_s

				route_obj = Route.find_by_no_and_direction(r_no, r_direction)

				unless route_obj
					@stop1.routes.create(no: r_no, direction: r_direction)
				else # if exist
					unless StopTime.find_by_stop_id_and_route_id(@stop1, route_obj)
						stop_time = @stop1.stop_times.create()
						stop_time.route = route_obj
						stop_time.save
					end
				end

			end
		end
		@routes1 = @stop1.routes

		if @stop2.expired?
			response2 = Nokogiri::HTML(RestClient.post(
				ENV['GetRouteSummaryForStop'],
				{ :apiKey => ENV['apiKey'],
					:appID => ENV['appID'],
					:stopNo => @stop2.code
					}))

			@stop2.refreshed

			response2.xpath("//route").each do |route|

				r_no = route.at("routeno").content.to_s
				r_direction = route.at("direction").content.to_s

				route_obj = Route.find_by_no_and_direction(r_no, r_direction)

				unless route_obj
					@stop2.routes.create(no: r_no, direction: r_direction)
				else # if exist
					unless StopTime.find_by_stop_id_and_route_id(@stop2, route_obj)
						stop_time = @stop2.stop_times.create()
						stop_time.route = route_obj
						stop_time.save
					end
				end

			end
		end
		@routes2 = @stop2.routes
	end

	def result
		@stop1 = Stop.find(params[:stop1])
		@stop2 = Stop.find(params[:stop2])
		@route1 = Route.find(params[:route1])
		@route2 = Route.find(params[:route2])

		@response1 = Nokogiri::HTML(RestClient.post(
			ENV['GetNextTripsForStop'],
			{ :apiKey => ENV['apiKey'],
				:appID => ENV['appID'],
				:stopNo => @stop1.code,
				:routeNo => @route1.no
				}))

		@rd_trips = []
		@response1.xpath("//routedirection").each do |rd|
			if @route1.direction == rd.at("direction").content.to_s
				Nokogiri.HTML(rd.to_s).xpath("//trip").each do |trip|
					@rd_trips << trip.at("adjustedscheduletime").content.to_i
				end
			end
		end

		@stop_time1 = StopTime.find_by_stop_id_and_route_id(@stop1, @route1)

		unless @stop_time1
			@stop_time1 = @stop1.stop_times.create()
			@stop_time1.route = @route1
			@stop_time1.save
		end

		@stop_time1.update_times(@rd_trips)


		@response2 = Nokogiri::HTML(RestClient.post(
			ENV['GetNextTripsForStop'],
			{ :apiKey => ENV['apiKey'],
				:appID => ENV['appID'],
				:stopNo => @stop2.code,
				:routeNo => @route2.no
				}))

		@rd_trips = []
		@response2.xpath("//routedirection").each do |rd|
			if @route2.direction == rd.at("direction").content.to_s
				Nokogiri.HTML(rd.to_s).xpath("//trip").each do |trip|
					@rd_trips << trip.at("adjustedscheduletime").content.to_i
				end
			end
		end

		@stop_time2 = StopTime.find_by_stop_id_and_route_id(@stop2, @route2)
		unless @stop_time2
			@stop_time2 = @stop2.stop_times.create()
			@stop_time2.route = @route2
			@stop_time2.save
		end
		@stop_time2.update_times(@rd_trips)

	end
end
