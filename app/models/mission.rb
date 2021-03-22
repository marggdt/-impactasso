class Mission < ApplicationRecord
  belongs_to :asso, dependent: :destroy
  has_many :favorites

  def in_favorite?(user)
    self.favorites.find{|favorite| favorite.user_id == user.id}
  end

end
