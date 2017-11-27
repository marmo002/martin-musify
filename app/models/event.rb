class Event < ApplicationRecord
  belongs_to :artist, optional: true
  belongs_to :venue, optional: true
  has_many :images
  has_many :genres, through: :artist


  scope :random_event, -> { order("RANDOM()") }

end
