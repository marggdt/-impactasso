class Mission < ApplicationRecord
  belongs_to :asso, dependent: :destroy
  has_many :favorites
  
end
