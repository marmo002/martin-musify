class Artist < ApplicationRecord
  has_many :events
  has_and_belongs_to_many :genres
  has_many :artist_socials

  validates :name, presence: true, on: :create
  validates :artist_tm_id, uniqueness: true
  validates :artist_tm_id, presence: true, on: :create
end
