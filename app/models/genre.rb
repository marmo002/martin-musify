class Genre < ApplicationRecord
  paginates_per 12

  has_and_belongs_to_many :artists
  has_many :events, through: :artists
end
