class Artist < ApplicationRecord
  has_many :events
  has_and_belongs_to_many :genres

end
