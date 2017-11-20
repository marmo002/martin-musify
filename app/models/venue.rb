class Venue < ApplicationRecord
  include Her::Model

  has_many :events
end
