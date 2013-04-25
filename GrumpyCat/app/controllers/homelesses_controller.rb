require 'sunlight'

class HomelessesController < ApplicationController

  def index
    @homelesses = Homeless.all
  end 

  def create
    congresspeople = Sunlight::Legislator.all_for(:latitude => lat, :longitude => long)
    representative = congresspeople[:representative]
 
    firstname = representative.firstname
    lastname = representative.lastname
    name = representative.firstname + representative.lastname
    email = representative.email

    i = 0
    while i < count do
      homeless = Homeless.new
      homeless.latitude = lat
      homeless.longitude = long
      homeless.email = email
      homeless.representative = name
      i++
    end 
  
  end

end
