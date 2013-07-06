class CompareController < ApplicationController
	def select_stops
		@stops = Stop.all
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

			response1.xpath("//route").each do |route|

				r_no = route.at("routeno").content.to_s
				r_direction = route.at("direction").content.to_s

				route_obj = Route.find_by_no_and_direction(r_no, r_direction)

				unless route_obj
					@stop1.routes.create(no: r_no, direction: r_direction)
				else # if exist
					unless StopTime.find_by_stop_id_and_route_id(@stop1, route_obj)
						@stop1.stop_times.create(route_id: route_obj)
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

			response2.xpath("//route").each do |route|

				r_no = route.at("routeno").content.to_s
				r_direction = route.at("direction").content.to_s

				route_obj = Route.find_by_no_and_direction(r_no, r_direction)

				unless route_obj
					@stop2.routes.create(no: r_no, direction: r_direction)
				else # if exist
					unless StopTime.find_by_stop_id_and_route_id(@stop2, route_obj)
						@stop2.stop_times.create(route_id: route_obj)
					end
				end

			end
		end
		@routes2 = @stop2.routes
	end

	def result
		@route1 = params[:route1]
		@route2 = params[:route2]
	end
end
