class Route < ActiveRecord::Base
  attr_accessible :direction, :no

  has_many :stop_times
  has_many :stops, through: :stop_times

  validates_uniqueness_of :no, scope: :direction
  validates_presence_of :no
  validates_presence_of :direction

  def full_name
  	"#{no} - #{direction}"
  end

  def abbr_name
  	"<abbr title='#{self.full_name}'>Route #{self.no}</abbr>".html_safe
  end

end
