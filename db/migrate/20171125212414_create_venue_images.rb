class CreateVenueImages < ActiveRecord::Migration[5.1]
  def change
    create_table :venue_images do |t|
      t.string :ratio
      t.string :url
      t.belongs_to :venue
      t.timestamps
    end
  end
end
