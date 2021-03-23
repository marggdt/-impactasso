require 'csv'
PgSearch::Document.delete_all
Favorite.delete_all
Mission.delete_all
Asso.delete_all
User.delete_all



puts "#{PgSearch::Document.count}-#{Favorite.count}-#{Mission.count}-#{Asso.count}-#{User.count}"
puts 'DB clean'
puts '==================='
# Asso.delete_all
# file_assos_csv = File.join(__dir__, '../data/assos.csv')
# sql = <<-SQL
#   COPY public.assos (name, description, address, zipcode, city, longitude, latitude)
#   FROM '#{file_assos_csv}'
#   DELIMITER ','
#   CSV HEADER QUOTE '"'
# SQL
# ActiveRecord::Base.connection.execute(sql)

puts "Begin fill database"

file_missions_csv = File.join(__dir__, '../data/missions.csv')
csv_options = { headers: true, col_sep: ',', liberal_parsing: true }
assos = []

missing_match = []
missing_assos_from_mission_csv = File.join(__dir__, '../data/missing_assos_from_mission.csv')

CSV.open(missing_assos_from_mission_csv, 'wb') do |csv|
  CSV.foreach(file_missions_csv, csv_options) do |row|

    # exit if i == 30
    # asso_name = row[5].gsub("Association :", "").strip
    asso_name = row[5].delete_prefix('Association : ')
    asso_name.squish!
    asso_name = asso_name.split(' - ').first
    asso_name.squish!


    assos << asso_name if asso_name.present?
    found_asso = Asso.where("name ILIKE ?", "%#{asso_name}%")


    web_scraper_start_url = row[1]
    lieu = row[3].delete_prefix('Lieu : ')
    type_mission = row[4].delete_prefix('Type : ')
    date_mission = row[6].delete_prefix('Date : ')
    dispo = row[7].delete_prefix('Disponibilité demandée : ')
    title = row[2]
    if  !found_asso.empty? && asso_name.present?
      m = Mission.create(asso_id: found_asso.first.id, web_scraper_start_url: web_scraper_start_url, lieu: lieu, type_mission: type_mission, date_mission: date_mission, dispo: dispo, title: title)
      # puts "Mission #{m.web_scraper_start_url}, asso: #{m.asso.name}"
    elsif debug
      csv << row.to_h.values
    end

  end

end

exit

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
  mode: "culture",
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
  alimentation: "alimentaire",
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
  urbaniste: "culture",
  peinture: "art",
  valeur: "social",
  commune: "social",
  chant: "art",
  chorale: "art",
  instrument: "art",
  video: "art",
  cinema: "art",
  photo: "art",
  solidaire: "social",
  kermesse: "social",
  seminaire: "politique",
  spectacle: "art",
  humanitaire: "social",
  boxe: "sport",
  karate: "sport",
  course: "sport",
  hockey: "sport",
  roller: "sport",
  longboard: "sport",
  skate: "sport",
}


# CATEGORIE_IMAGE = {
#   sport: "sport.svg",
#   santé: "sante.svg",
#   education: "ecucation.svg",
#   culture: "culture.svg",
#   social: "social.svg",
#   environement: "environnement.svg",
#   animaux: "animaux.svg",
#   alimentaire: "alimentation.svg",
# }

Asso.all.each do |asso|

  CATEGORIES.each do |key, value|
    if I18n.transliterate(asso.description).downcase.include?(key.to_s)
      asso.category = value
      asso.save!
    end
  end
end
# Asso.all.each do |asso|
#   if asso.category.nil?
#     asso.image_url = "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw4HBg8NBw4QEBASDQ4NDRcKDw8IEA4SFREWGBcdFRMYKCghJBolJx8TLTEtJSkrOi4uFyszODMsNygtOisBCgoKDg0NDw8PDy0ZFRkrKystKysrKystKystLSsrKysrKysrKysrKysrLSsrKysrLSsrKysrKysrKysrKysrK//AABEIAH4AyAMBIgACEQEDEQH/xAAbAAEBAAMBAQEAAAAAAAAAAAAABQEEBgMCB//EADEQAAIBAgMGBQMDBQAAAAAAAAABAgMRBBIxBSEiQVFhcYGRobETwfEzQnIUMmKCkv/EABgBAQEBAQEAAAAAAAAAAAAAAAACAwEE/8QAHREBAQEBAQACAwAAAAAAAAAAAAECETEhQRITMv/aAAwDAQACEQMRAD8A/RAAelkAAAAAAAAAAADMIupO0Fd8rLM2UaGyZS/XeXtHifrovc5dSeuydTTKTb4fZZjoaWApU1ujf+XEeleEvoSVDdK3D0TI/Y7+LmGrPf53MmaicZNVNb77637mDRIAAAAAAAAAAAAAAAAAAAAAAAAelCi61VRh156Jc2zzKmw4Xc5PklFfP2ROryddk7W/hMJDCwtDXm2t7NoAw9aAAA1MZhI4qO/dLk1r+Dn6tN0qjjPVHVEXbsLVoSWri16fkvF+eJsTQAbIAAAAAAAAAAAAAAAAAAAAAAsbC/Sn/JfBHK2wVw1PGL+SN+O59VwAYtAAAER9vf3U/wDf7FdEjbr4qfhL7FY/py+JQAN2YAAAAAAAAAAAAAAAAAAAAAF3ZMIrCqUVvk3fvZuxCLuy0o0Mqld7pvdlyppO3fxM9+KnqgADJYAABL21CP0FKS33yx899vYqE3bPFQtfR5muq0+53PscviIAD0MwAAAAAAAAAAAAAAAAAAAAAN/BVLV6Un0dKXjfd8r0NA9sO78C5tOHaS09dPQnU7HY6cGvhK39RQU0uz7PmbBg0AABg5/HVM85tfuqZV4RVr+bfsV8bX+jQvHe28sbdXoQK747R0isq7u92/VsvE+02vMAGyAAAAAAAAAAAAAAAAAAAAAAMJ2e7rdGT7oQ+pVjHq0nbuwL2zmnhs0f3Scn2fP3TNxnlQpKjSUIaLS56M899axkAHBO2vJww1465ku6umrruQzpsRRjiKeWpprueVnNThkm0+TafijXF+OI0wADRIAAAAAAAAAAAAAAAAAAANmhgKlbSOVdZcK9NWU8PsuFP9Tjf+WnoTdyOyVGpUZ1nanFvrZbl4vRFXA7N+jUU6r38kluXmUoRUVaKsuVllPozu7VTLIAIUAAAScbs11KjnRe9u7T69mVjB2WzxyzrlqtGdGVqqcfFbn4PmfB1M4KcbTV1zusxoYjZMJ76XC/+kaTc+03KKDYr4KpQ1V11jxfjzNcuXqQAHQAAAAAAAAAAHrhqEsRUy0/F30S6st4XAQw6ulml1kvjofGyaahhYtayu2UDHerbxpIAAh0AAAAAAAAAAAAADQxWz4YhXjwy6xXyjfMXOy8OOWr0ZUKmWevK2jXVdj4LW2Kanh83NW9HyIptm9jOzlAAU4AAD//2Q=="
#   else
#     CATEGORIE_IMAGE.each do |key, value|
#       asso.image_url = value if asso.category.to_sym == key
#     end
#   end

#   asso.save!
# end

