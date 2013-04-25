class Homeless < ActiveRecord::Base
  attr_accessible :address, :district, :email, :latitude, :longitude, :representative
end
