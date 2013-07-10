class Stop < ActiveRecord::Base

  acts_as_gmappable lat: "lat", lng: "long", process_geocoding: false

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
    #expires_at.blank? or 2.days.from_now > expires_at
  end

  def refreshed
    self.increment!(:refresh_count)
    self.update_attribute(:expires_at, 1.day.from_now)
  end

  def gmaps4rails_infowindow
    "#{self.full_name}"
  end

  def routes_with_refresh
    if self.expired?
      response = Nokogiri::HTML(RestClient.post(
        ENV['GetRouteSummaryForStop'],
        { :apiKey => ENV['apiKey'],
          :appID => ENV['appID'],
          :stopNo => self.code
          }))

      self.refreshed

      response.xpath("//route").each do |route_node|

        r_no = route_node.at("routeno").content.to_s
        r_direction = route_node.at("direction").content.to_s

        route = Route.find_by_no_and_direction(r_no, r_direction)

        unless route
          self.routes_without_refresh.create(no: r_no, direction: r_direction)
        else
          self.stop_times.find_or_create_by_route_id(route.id)
        end

      end
    end
    self.routes_without_refresh
  end
  alias_method_chain :routes, :refresh

end
