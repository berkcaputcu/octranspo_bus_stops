class Stop < ActiveRecord::Base
  attr_accessible :stop_id, :stop_code, :stop_name

  validates :stop_id, uniqueness: true
  validates_presence_of :stop_id
  validates_presence_of :stop_code
  validates_presence_of :stop_name

  default_scope order('stop_code ASC')

  def full_name
  	"#{stop_code} - #{stop_name}"
  end
end
