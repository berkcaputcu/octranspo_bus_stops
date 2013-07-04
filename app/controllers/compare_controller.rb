class CompareController < ApplicationController
	def select_stops
		@stops = Stop.all
	end

	def select_routes
		@stop1 = params[:stop1]
		@stop2 = params[:stop2]

		response1 = Nokogiri::HTML(RestClient.post(
			ENV['GetRouteSummaryForStop'],
			{ :apiKey => ENV['apiKey'],
				:appID => ENV['appID'],
				:stopNo => @stop1
				}))

		@routes1=[]
		@routes2=[]

		response1.xpath("//route").each do |route|
			@routes1 << {no: route.at("routeno").content.to_s, direction: route.at("direction").content.to_s}
		end

		response2 = Nokogiri::HTML(RestClient.post(
			ENV['GetRouteSummaryForStop'],
			{ :apiKey => ENV['apiKey'],
				:appID => ENV['appID'],
				:stopNo => @stop2
				}))

		response2.xpath("//route").each do |route|
			@routes2 << {no: route.at("routeno").content.to_s, direction: route.at("direction").content.to_s}
		end
	end

	def result
	end
end
