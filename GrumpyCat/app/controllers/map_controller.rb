class MapController < ApplicationController

  def index
    @json = Homeless.all.to_gmaps4rails
  end

end
