class CreateVenueImages < ActiveRecord::Migration[5.1]
  def change
    create_table :venue_images do |t|

      t.timestamps
    end
  end
end
