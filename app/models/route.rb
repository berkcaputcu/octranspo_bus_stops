class Route < ActiveRecord::Base
  attr_accessible :direction, :no

  has_many :stop_times
  has_many :stops, through: :stop_times

end
