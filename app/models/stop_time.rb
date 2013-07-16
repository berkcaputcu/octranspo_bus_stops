class StopTime < ActiveRecord::Base
  belongs_to :stop
  belongs_to :route

  has_many :adjusted_times
  has_many :favorites
  has_many :favorited_users, through: :favorites, class_name: "User"
  
  validates_uniqueness_of :stop_id, scope: :route_id

  after_create :initialize_adjusted_times

  def update_times

    response = Nokogiri::HTML(RestClient.post(
      ENV['GetNextTripsForStop'],
      { :apiKey => ENV['apiKey'],
        :appID => ENV['appID'],
        :stopNo => stop.code,
        :routeNo => route.no
        }))

    response.xpath("//routedirection").each do |rd|
      if route.direction == rd.at("direction").content.to_s
        Nokogiri.HTML(rd.to_s).xpath("//trip").each_with_index do |trip, index|
          if index < self.adjusted_times.size
            self.adjusted_times[index].update_with_trip(trip)
          end
        end
        break
      end
    end
  end

  def initialize_adjusted_times
    3.times { self.adjusted_times.create }
  end

end
