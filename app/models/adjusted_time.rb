class AdjustedTime < ActiveRecord::Base

	acts_as_gmappable process_geocoding: false

	belongs_to :stop_time

	attr_accessible :age, :latitude, :longitude, :time_left

	def scheduled?
		self.age < 0
	end

	def update_with_trip (trip)
		self.time_left = trip.at("adjustedscheduletime").content.to_i
		self.age = trip.at("adjustmentage").content.to_f
		self.latitude = trip.at("latitude").content.to_f
		self.longitude = trip.at("longitude").content.to_f
		self.save
	end

	def gmaps4rails_infowindow
		"#{self.route.full_name}"
	end

	def route
		self.stop_time.route
	end

	def stop
		self.stop_time.stop
	end

end
