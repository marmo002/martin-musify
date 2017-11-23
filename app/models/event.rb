class Event < ApplicationRecord
  belongs_to :artist, optional: true, foreign_key: 'artist_tm_id'
  belongs_to :venue, optional: true, foreign_key: 'venue_tm_id'
  has_many :images
end
