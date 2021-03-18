class Mission < ApplicationRecord
  belongs_to :asso, dependent: :destroy
  has_many :favorites

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

end
