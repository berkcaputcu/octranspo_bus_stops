class Stop < ActiveRecord::Base
  attr_accessible :name, :code, :lat, :long, :expires_at

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

  # add method for rotues => refresh routes before sending

end
