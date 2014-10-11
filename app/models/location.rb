class Location < ActiveRecord::Base
  has_many :visits
  has_many :visitors, through: :visits

  serialize :bounds, Hash
end
