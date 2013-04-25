require 'sunlight'

class HomelessesController < ApplicationController

  def show
    @homeless = Homeless.find(params[:id])
  end 

  def nearby
    @homelesses = Homeless.all
  end 

  def index
    @homelesses = Homeless.all
  end 

  def create

    lat = params[:lat]
    long = params[:long]
    count = params[:count].to_i

    lat = lat.sub("P",".")
    long = long.sub("P",".")

    congresspeople = Sunlight::Legislator.all_for(:latitude => lat, :longitude => long)
    representative = congresspeople[:representative]
 
    firstname = representative.firstname
    lastname = representative.lastname
    name = representative.firstname + " " + representative.lastname
    email = representative.email
    district = representative.district

    @first_homeless = nil
    i = 0
    while i < count do
      homeless = Homeless.new
      homeless.latitude = lat
      homeless.longitude = long
      homeless.email = email
      homeless.district = district
      homeless.representative = name
      homeless.save
      if i == 0
        @first_homeless = homeless
      end
      i = i+1
    end 
  
    respond_to do |format|
      format.json { render :json => @first_homeless }
    end
 
  end

end
