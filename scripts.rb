# \copy mission.csv (att1, att2, ...) FROM 'fichier.csv' WITH CSV DELIMITER ';' QUOTE '"'

require 'csv'

csv_options = { col_sep: ',', quote_char: '"', headers: :title, :infos, :web_scraper_order, :web_scraper_url }
filepath    = 'missions.csv'

CSV.foreach(filepath, csv_options) do |row|
  puts "title: #{row['Name']}"
  puts "#{row['Appearance']} beer from #{row['Origin']}"
end