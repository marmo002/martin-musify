class ArtistGenre < ActiveRecord::Migration[5.1]
  def change
    create_join_table :artists, :genres do |t|
      t.belongs_to :artist
      t.belongs_to :genre
    end
  end
end
