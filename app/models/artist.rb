class Artist < ApplicationRecord
  has_many :events, foreign_key: :artist_tm_id
  has_and_belongs_to_many :genres
end
