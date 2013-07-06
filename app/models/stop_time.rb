class StopTime < ActiveRecord::Base
  belongs_to :stop
  belongs_to :route
  
  attr_accessible :time_left1, :time_left2, :time_left3

  validates_uniqueness_of :stop_id, scope: :route_id

  def update_times(times)
  	self.time_left1 = times[0] unless times[0].blank?
  	self.time_left2 = times[1] unless times[1].blank?
  	self.time_left3 = times[2] unless times[2].blank?

  	self.save
  end
end
