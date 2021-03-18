json.array! @assos do |asso|
  json.extract! asso, :id, :name, :address, :description, :address, :city, :zipcode, :longitude, :latitude
end

