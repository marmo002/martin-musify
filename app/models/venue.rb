class Venue < ApplicationRecord
  paginates_per 12
  geocoded_by :full_address
  after_validation :geocode

  has_many :events
  has_many :venue_images
end
