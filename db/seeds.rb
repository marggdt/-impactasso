# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
  medecin: "hopital",
  medicaux: "hopital",
  infirmier: "hopital",
  medical: "hopital",
  hopital: "hopital",
  handicape: "hopital",
  malade: "hopitaux",
  education: "education",
  scolaire: "education",
  ecole: "education",
  enseignement: "education",
  formation: "education",
  etude: "education",
  enseignants: "education",
  educatif: "education",
  famille: "famille",
  culture: "culture",
  musique: "culture",
  universite: "culture",
  histoire: "culture",
  musical: "culture",
  artiste: "art",
  theatre: "art",
  art: "art",
  mode: "mode",
  vetements: "mode",
  relation: "social",
  interet: "social",
  entraide: "social",
  interets: "social",
  sociaux: "social",
  amitie: "social",
  accueil: "social",
  enfant: "social",
  defense: "social",
  defendre: "social",
  ectivite: "social",
  humain: "social",
  rencontre: "social",
  moral: "social",
  commune: "village",
  paroisse: "religion",
  edification: "religion",
  eglise: "religion",
  pretre: "religion",
  moine: "religion",
  industrie: "alimentaire",
  agricole: "alimentaire",
  denrhe: "alimentaire",
  alimentation: "alimentation",
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
  politique: "politique",
  demographie: "politique",
  demographique: "politique",
  urbaniste: "politique"
}

CATEGORIE_IMAGE = {
  sport: "test",
  hopital: "url",
  education: "",
  famille: "",
  culture: "",
  art: "",
  mode: "",
  social: "",
  village: "",
  religion: "",
  alimentaire: "",
  animaux: "",
  environnement: "",
  politique: ""
}

Asso.first(50).each do |asso|
  CATEGORIES.each do |key, value|
    if I18n.transliterate(asso.description).downcase.include?(key.to_s)
      asso.category = value
      asso.save!
    end
  end
end

    #   asso.category =
    # category_images[value]






# Asso.where("description LIKE ?", "%boules%").all.length
