class Visitor < ActiveRecord::Base
  has_many :visits
  has_many :locations, through: :visits



  def self.response
    response = RestClient.get 'https://10.10.20.11/api/contextaware/v1/location/clients', {params: {floor: "Main Floor"}, accept: :json, authorization: 'Basic bGVhcm5pbmc6bGVhcm5pbmc=' }
    parser(JSON.parse(response)["Locations"]["entries"])
  end

  def self.parser(visitor_list)
    visitor_list.each do |entry|
      visitor = Visitor.find_or_create_by({mac_id: entry["macAddress"]})
      location_id = Location.get_location(entry["MapCoordinate"])
      if visitor.at_location == 0
        Visit.create({visitor_id: visitor.id, location_id: location_id, start: entry["Statistics"]["lastLocatedTime"]})
        visitor.update({at_location: location_id})
      end
    end
  end
end
