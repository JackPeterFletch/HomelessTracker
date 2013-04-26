json.homelesses @homelesses.each do |json, homeless|
  json.(homeless, :id, :latitude, :longitude, :address, :district, :representative, :email, :gender, :office, :phone, :twitter)
end
