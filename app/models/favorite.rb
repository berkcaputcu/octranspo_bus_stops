class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :stop_time

  attr_accessible :stop_time_id
end
