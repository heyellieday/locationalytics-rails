class Visitor < ActiveRecord::Base
  has_many :visits
  has_many :locations, through: :visits

  def self.response
    response = RestClient.get 'https://10.10.20.11/api/contextaware/v1/location/clients', {params: {floor: "Main Floor"}, accept: :json, authorization: 'Basic bGVhcm5pbmc6bGVhcm5pbmc=' }
    visitor_list = JSON.parse(response)["Locations"]["entries"]
    parser(visitor_list)
    check_present(visitor_list)
  end

  def self.parser(visitor_list)
    visitor_list.each do |entry|
      visitor = Visitor.find_or_create_by({mac_id: entry["macAddress"]})
      location_id = Location.get_location(entry["MapCoordinate"])
      start_time = entry["Statistics"]["lastLocatedTime"]
      if visitor.at_location == 0 && location_id != 0
        Visit.create({visitor_id: visitor.id, location_id: location_id, start: start_time})
        visitor.update({at_location: location_id})
      elsif visitor.at_location != location_id && location_id != 0
        visitor.visits.last.update({end: start_time})
        visitor.update({at_location: location_id})
        Visit.create({visitor_id: visitor.id, location_id: location_id, start: start_time})
      elsif visitor.at_location != location_id && location_id == 0
        visitor.visits.last.update({end: start_time})
        visitor.update({at_location: location_id})
      end
    end
  end

  def self.check_present(visitor_list)
    current_visitors = Visitor.where.not(at_location:0)
    current_visitors.each do |visitor|
      if !is_present(visitor,visitor_list)
        visitor.visits.last.update({end: visitor_list.first["currentServerTime"]})
        visitor.update({at_location: 0})
      end
    end
  end

  def self.is_present(visitor,visitor_list)
    visitor_list.each do |visit|
      if visit["macAddress"] == visitor.mac_id
        return true
      end
    end
    false
  end
end
