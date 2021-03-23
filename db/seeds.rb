require 'csv'
PgSearch::Document.delete_all
Favorite.delete_all
Mission.delete_all
Asso.delete_all
User.delete_all



puts "#{PgSearch::Document.count}-#{Favorite.count}-#{Mission.count}-#{Asso.count}-#{User.count}"
puts 'DB clean'
puts '==================='

puts 'Created user'
u = User.create(email: 'nona@test.fr', password: 'azerty')
puts "Users: #{User.count}"



csv_options = { headers: true, col_sep: ',', liberal_parsing: true }

puts "Create assos"
file_assos_csv = File.join(__dir__, '../data/assos.csv')
sql = <<-SQL
  COPY public.assos (name, description, address, zipcode, city, longitude, latitude)
  FROM '#{file_assos_csv}'
  DELIMITER ','
  CSV HEADER QUOTE '"'
SQL
ActiveRecord::Base.connection.execute(sql)

puts "Assos: #{Asso.count}"

puts "Create missions"

file_missions_csv = File.join(__dir__, '../data/missions.csv')
assos = []


CSV.foreach(file_missions_csv, csv_options) do |row|
  web_scraper_start_url = row[1]
  lieu = row[3].delete_prefix('Lieu : ')
  type_mission = row[4].delete_prefix('Type : ')
  date_mission = row[6].delete_prefix('Date : ')
  dispo = row[7].delete_prefix('Disponibilité demandée : ')
  title = row[2]


  asso_name = row[5].delete_prefix('Association : ')
  asso_name.squish!
  asso_name = asso_name.split(' - ').first
  asso_name.squish!

  assos << asso_name if asso_name.present?
  found_asso = Asso.where("name ILIKE ?", "%#{asso_name}%")

  if  !found_asso.empty? && asso_name.present?
    m = Mission.create(
      asso_id: found_asso.first.id,
      web_scraper_start_url: web_scraper_start_url,
      lieu: lieu,
      type_mission: type_mission,
      date_mission: date_mission,
      dispo: dispo,
      title: title
    )
    puts "Mission #{m.web_scraper_start_url[0..25]}, asso: #{m.asso.name}"
  end
end

puts "Missions: #{Mission.count}"

puts "Add categories to assos"

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

Asso.all.find_each do |asso|
  CATEGORIES.each do |key, value|
    if I18n.transliterate(asso.description).downcase.include?(key.to_s)
      asso.category = value
      asso.save!
      puts "Modify category asso: #{asso.name}"
    end
  end
end

puts "Categories added to assos"

puts "Seeds finished !"
