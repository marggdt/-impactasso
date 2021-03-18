# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

Mission.delete_all
Asso.delete_all

file_assos_csv = File.join(__dir__, '../data/assos.csv')

sql = <<-SQL
  COPY public.assos (name, description, address, zipcode, city, longitude, latitude)
  FROM '#{file_assos_csv}'
  DELIMITER ','
  CSV HEADER QUOTE '"'
SQL
ActiveRecord::Base.connection.execute(sql)

puts "Asso created"



file_missions_csv = File.join(__dir__, '../data/missions.csv')

sql = <<-SQL
  COPY public.missions (web_scraper_order, web_scraper_start_url, title, lieu, type_mission, asso, date_mission, dispo)
  FROM '#{file_missions_csv}'
  DELIMITER ','
  CSV HEADER QUOTE '"'
SQL
ActiveRecord::Base.connection.execute(sql)


puts "Mission created"

csv_options = { headers: true, col_sep: ',', liberal_parsing: true }

assos = []

CSV.foreach(file_missions_csv, csv_options) do |row|

  # asso_name = row[5].gsub("Association :", "").strip
  # found_asso = Asso.where(name: asso_name)


  asso_name = row[5].delete_prefix('Association : ')
  asso_name.squish!
  asso_name = asso_name.split('-')[0...-1].join('-')
  asso_name.squish!

  assos << asso_name if asso_name.present?


  # if found_asso
  #   Mission.create(name: asso_name, description: )
  # end

end

puts assos.uniq.count
# puts missions


CATEGORIES = {
  foot: "sport",
  tennis: "sport",
  golf: "sport",
  danse: "sport",
  federation: "sport",
  gymnastique: "sport",
  yoga: "sport",
  volley_ball: "sport",
  club: "sport",
  baseball: "sport",
  clyclisme: "sport",
  sportive: "sport",
  sport: "sport",
  loisir: "sport",
  parachutisme: "sport",
  athletisme: "sport",
  natation: "sport",
  basket: "sport",
  boule: "sport",
  chasse: "sport",
  petanque: "sport",
  epreuve: "sport",
  medecin: "santé",
  medicaux: "santé",
  infirmier: "santé",
  medical: "santé",
  hopital: "santé",
  handicape: "santé",
  malade: "santé",
  education: "education",
  scolaire: "education",
  ecole: "education",
  enseignement: "education",
  formation: "education",
  etude: "education",
  enseignants: "education",
  educatif: "education",
  famille: "social",
  culture: "culture",
  musique: "culture",
  universite: "culture",
  histoire: "culture",
  musical: "culture",
  artiste: "culture",
  theatre: "culture",
  art: "culture",
  mode: "social",
  vetements: "social",
  relation: "social",
  internet: "social",
  entraide: "social",
  interets: "social",
  sociaux: "social",
  amitie: "social",
  accueil: "social",
  enfant: "social",
  defense: "social",
  defendre: "social",
  activite: "social",
  humain: "social",
  rencontre: "social",
  moral: "social",
  paroisse: "culture",
  edification: "culture",
  eglise: "culture",
  pretre: "culture",
  moine: "culture",
  industrie: "alimentaire",
  agricole: "alimentaire",
  denrhe: "alimentaire",
  alimentation: "alimentataire",
  degustation: "alimentaire",
  animal: "animaux",
  animaux: "animaux",
  elevage: "animaux",
  gibier: "animaux",
  canine: "animaux",
  animale: "animaux",
  environnement: "environnement",
  climat: "environnement",
  rechauffement: "environnement",
  politique: "culture",
  demographie: "culture",
  demographique: "culture",
  urbaniste: "culture"
}

CATEGORIE_IMAGE = {
  sport: "https://source.unsplash.com/random",
  santé: "https://source.unsplash.com/random",
  education: "https://source.unsplash.com/random",
  culture: "https://source.unsplash.com/random",
  social: "https://source.unsplash.com/random",
  environement: "https://source.unsplash.com/random",
  animaux: "https://source.unsplash.com/random",
  alimentaire: "https://source.unsplash.com/random",
}

Asso.all.each do |asso|
  CATEGORIES.each do |key, value|
    if I18n.transliterate(asso.description).downcase.include?(key.to_s)
      asso.category = value
      asso.save!
    end
  end
end

Asso.all.each do |asso|
  if asso.category.nil?
    asso.image_url = "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw4HBg8NBw4QEBASDQ4NDRcKDw8IEA4SFREWGBcdFRMYKCghJBolJx8TLTEtJSkrOi4uFyszODMsNygtOisBCgoKDg0NDw8PDy0ZFRkrKystKysrKystKystLSsrKysrKysrKysrKysrLSsrKysrLSsrKysrKysrKysrKysrK//AABEIAH4AyAMBIgACEQEDEQH/xAAbAAEBAAMBAQEAAAAAAAAAAAAABQEEBgMCB//EADEQAAIBAgMGBQMDBQAAAAAAAAABAgMRBBIxBSEiQVFhcYGRobETwfEzQnIUMmKCkv/EABgBAQEBAQEAAAAAAAAAAAAAAAACAwEE/8QAHREBAQEBAQACAwAAAAAAAAAAAAECETEhQRITMv/aAAwDAQACEQMRAD8A/RAAelkAAAAAAAAAAADMIupO0Fd8rLM2UaGyZS/XeXtHifrovc5dSeuydTTKTb4fZZjoaWApU1ujf+XEeleEvoSVDdK3D0TI/Y7+LmGrPf53MmaicZNVNb77637mDRIAAAAAAAAAAAAAAAAAAAAAAAAelCi61VRh156Jc2zzKmw4Xc5PklFfP2ROryddk7W/hMJDCwtDXm2t7NoAw9aAAA1MZhI4qO/dLk1r+Dn6tN0qjjPVHVEXbsLVoSWri16fkvF+eJsTQAbIAAAAAAAAAAAAAAAAAAAAAAsbC/Sn/JfBHK2wVw1PGL+SN+O59VwAYtAAAER9vf3U/wDf7FdEjbr4qfhL7FY/py+JQAN2YAAAAAAAAAAAAAAAAAAAAAF3ZMIrCqUVvk3fvZuxCLuy0o0Mqld7pvdlyppO3fxM9+KnqgADJYAABL21CP0FKS33yx899vYqE3bPFQtfR5muq0+53PscviIAD0MwAAAAAAAAAAAAAAAAAAAAAN/BVLV6Un0dKXjfd8r0NA9sO78C5tOHaS09dPQnU7HY6cGvhK39RQU0uz7PmbBg0AABg5/HVM85tfuqZV4RVr+bfsV8bX+jQvHe28sbdXoQK747R0isq7u92/VsvE+02vMAGyAAAAAAAAAAAAAAAAAAAAAAMJ2e7rdGT7oQ+pVjHq0nbuwL2zmnhs0f3Scn2fP3TNxnlQpKjSUIaLS56M899axkAHBO2vJww1465ku6umrruQzpsRRjiKeWpprueVnNThkm0+TafijXF+OI0wADRIAAAAAAAAAAAAAAAAAAANmhgKlbSOVdZcK9NWU8PsuFP9Tjf+WnoTdyOyVGpUZ1nanFvrZbl4vRFXA7N+jUU6r38kluXmUoRUVaKsuVllPozu7VTLIAIUAAAScbs11KjnRe9u7T69mVjB2WzxyzrlqtGdGVqqcfFbn4PmfB1M4KcbTV1zusxoYjZMJ76XC/+kaTc+03KKDYr4KpQ1V11jxfjzNcuXqQAHQAAAAAAAAAAHrhqEsRUy0/F30S6st4XAQw6ulml1kvjofGyaahhYtayu2UDHerbxpIAAh0AAAAAAAAAAAAADQxWz4YhXjwy6xXyjfMXOy8OOWr0ZUKmWevK2jXVdj4LW2Kanh83NW9HyIptm9jOzlAAU4AAD//2Q=="
  else
    CATEGORIE_IMAGE.each do |key, value|
      asso.image_url = value if asso.category.to_sym == key
    end
  end

  asso.save!
end
