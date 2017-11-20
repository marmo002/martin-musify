class Event < ApplicationRecord
  include Her::Model

  belongs_to :artist
  belongs_to :venue

end
