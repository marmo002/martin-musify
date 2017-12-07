class CreateArtistSocials < ActiveRecord::Migration[5.1]
  def change
    create_table :artist_socials do |t|
      t.string :url
      t.string :name
      t.belongs_to :artist

      t.timestamps
    end
  end
end
