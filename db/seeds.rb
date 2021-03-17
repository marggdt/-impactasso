# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

Asso.delete_all
Mission.delete_all

file_assos_csv = File.join(__dir__, '../data/assos.csv')

sql = <<-SQL
  COPY public.assos (name, description, address, city, zipcode, longitude, latitude)
  FROM '#{file_assos_csv}'
  DELIMITER ','
  CSV HEADER QUOTE '"'
SQL
ActiveRecord::Base.connection.execute(sql)


puts "Asso created"


file_missions_csv = File.join(__dir__, '../data/missions.csv')

sql = <<-SQL
  COPY public.missions (web_scraper_order, web_scraper_start_url, title, lieu, type, asso, date_mission, dispo)
  FROM '#{file_missions_csv}'
  DELIMITER ','
  CSV HEADER QUOTE '"'
SQL
ActiveRecord::Base.connection.execute(sql)


puts "Mission created"
