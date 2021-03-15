class Mission < ApplicationRecord
  belongs_to :association
  has_many :favorites
end
