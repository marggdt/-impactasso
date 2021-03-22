class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :mission
  validates :mission, uniqueness: { scope: :mission_id}
end
