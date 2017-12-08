class Venue < ApplicationRecord
  paginates_per 6
  geocoded_by :full_address
  after_validation :geocode

  has_many :events
  has_many :venue_images

  validates :name,          presence: true, on: :create
  validates :venue_tm_id,   uniqueness: true
  validates :venue_tm_id,   presence: true, on: :create
  validates :address_1,     presence: true, on: :create
  validates :city,          presence: true, on: :create
  validates :province,      presence: true, on: :create
  validates :postal_code,   presence: true, on: :create
  validates :country,       presence: true, on: :create
end
