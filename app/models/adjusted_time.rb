class AdjustedTime < ActiveRecord::Base

	acts_as_gmappable process_geocoding: false

	belongs_to :stop_time

	attr_accessible :age, :latitude, :longitude, :time_left

	def scheduled?
		self.age.blank? or self.age < 0
	end

	def coordinates
		"#{self.latitude}, #{self.longitude}"
	end

	def live?
		!scheduled?
	end

	def age_in_seconds
		if !self.age.blank?
			self.age * 60
		else
			-1 # scheduled time
		end
	end

	def arrival_time
		if !self.time_left.blank?
			self.time_left.minutes.from_now.localtime.strftime("%H:%M")
			# bug with local time, gets local time of the server
		else
			" - "
		end
	end

	def update_with_trip (trip)
		self.time_left = trip.at("adjustedscheduletime").content.to_i
		self.age = trip.at("adjustmentage").content.to_f
		self.latitude = trip.at("latitude").content.to_f
		self.longitude = trip.at("longitude").content.to_f
		self.save
	end

	def gmaps4rails_infowindow
		"""
		<strong>Route:</strong> #{self.route.full_name}<br>
		<strong>Stop:</strong> #{self.stop.full_name}<br>
		<strong>Time Left:</strong> #{self.time_left}
		"""
	end

	def route
		self.stop_time.route
	end

	def stop
		self.stop_time.stop
	end

end
