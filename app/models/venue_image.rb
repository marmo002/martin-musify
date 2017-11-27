class VenueImage < ApplicationRecord
 belongs_to :venue

 scope :venue_sixteen_by_nine, -> { where(ratio: "16_9") }
end
