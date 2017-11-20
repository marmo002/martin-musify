class Event < ApplicationRecord

  belongs_to :artist
  belongs_to :venue
  has_many :images

end
