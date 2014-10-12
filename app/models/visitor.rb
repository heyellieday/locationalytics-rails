class Visitor < ActiveRecord::Base
  has_many :visits
  has_many :locations, through: :visits

  def self.response
    response = RestClient.get 'https://10.10.20.11/api/contextaware/v1/location/clients', {params: {floor: "Main Floor"}, accept: :json, authorization: 'Basic bGVhcm5pbmc6bGVhcm5pbmc=' }
    parser(JSON.parse(response)["Locations"]["entries"])
  end

  def self.parser(visitor_list)
    visitor_list.map do |entry|
      visitor = Visitor.find_or_create_by({mac_id: entry["macAddress"]})
    end
  end
end
