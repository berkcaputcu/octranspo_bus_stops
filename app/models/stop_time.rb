class StopTime < ActiveRecord::Base
  belongs_to :stop
  belongs_to :route
  
  attr_accessible :time_left
end
