class Venue < ApplicationRecord
  geocoded_by :full_address
  after_validation :geocode

  has_many :events
end
