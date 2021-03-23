class Asso < ApplicationRecord
  has_many :missions, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_by_all,
    against: [ :name, :description, :category, :city, :zipcode ],
    using: {
      tsearch: { prefix: true }
    }

  scope :geocoded, -> { where.not(latitude: nil, longitude: nil) }

end
