require 'geocoder'

class Homeless < ActiveRecord::Base
  attr_accessible :address, :district, :email, :latitude, :longitude, :representative

  reverse_geocoded_by :latitude, :longitude
  after_validation :fetch_address
end
