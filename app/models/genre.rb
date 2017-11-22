class Genre < ApplicationRecord

  has_and_belongs_to_many :artists, foreign_key: 'tm_id'
end
