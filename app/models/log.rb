class Log < ActiveRecord::Base
	belongs_to :user
	belongs_to :stop_time

	attr_accessible :stop_time_id

	default_scope order('updated_at DESC')

	def stop
		self.stop_time.stop
	end

	def route
		self.stop_time.route
	end

end
