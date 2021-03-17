class Asso < ApplicationRecord
  has_many :missions
  include PgSearch::Model
  pg_search_scope :search_by_name_and_description, against: [ :name, :description ],
    using: {
      tsearch: { prefix: true }
    }
end
