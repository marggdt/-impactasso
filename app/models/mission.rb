class Mission < ApplicationRecord
  belongs_to :asso
  has_many :favorites

    include PgSearch::Model
    pg_search_scope :global_search,
    against: [:title, :lieu],
    associated_against: {
      asso: [:name, :description, :address, :category]
    },
    using: {
      tsearch: { prefix: true }
    }

  def in_favorite?(user)
    self.favorites.find{|favorite| favorite.user_id == user.id}
  end

end
