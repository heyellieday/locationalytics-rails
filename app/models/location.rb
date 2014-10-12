class Location < ActiveRecord::Base
  has_many :visits
  has_many :visitors, through: :visits

  serialize :bounds, Hash

  def self.get_location(coordinates)
    Location.all.each do |zone|
      if zone.bounds["minX"] <= coordinates["x"] && coordinates["x"] <= zone.bounds["maxX"] && zone.bounds["minY"] <= coordinates["y"] && coordinates["y"] <= zone.bounds["maxY"]
        return zone.id
      end
    end
    0
  end
end
