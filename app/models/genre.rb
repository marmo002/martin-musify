class Genre < ApplicationRecord
  has_and_belongs_to_many :artists
  has_many :events, through: :artists
end
