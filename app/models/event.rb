class Event < ApplicationRecord

  belongs_to :artist, optional: true, foreign_key: 'tm_id'
  belongs_to :venue, optional: true, foreign_key: 'tm_id'
  has_many :images

end
