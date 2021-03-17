require "csv"

filepath = "missions.csv"

CSV.foreach(filename, :headers => true) do |row|
  Missions.create!(row.to_hash)
end
