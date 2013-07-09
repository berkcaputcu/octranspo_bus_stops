class Stop < ActiveRecord::Base

  acts_as_gmappable lat: "lat", lng: "long"

  attr_accessible :name, :code, :lat, :long, :expires_at, :refresh_count

  has_many :stop_times
  has_many :routes, through: :stop_times

  validates_presence_of :code
  validates_presence_of :name

  default_scope order('code ASC')

  def full_name
  	"#{code} - #{name}"
  end

  def coordinates
  	"#{lat}, #{long}"
  end

  def expired?
  	expires_at.blank? or Time.now > expires_at
  end

  def refreshed
    self.increment!(:refresh_count)
    self.update_attribute(:expires_at, 1.day.from_now)
  end

  def gmaps4rails_infowindow
    "#{self.full_name}"
  end

  # add method for rotues => refresh routes before sending

end
