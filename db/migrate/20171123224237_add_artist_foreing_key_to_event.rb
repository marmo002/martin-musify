class AddArtistForeingKeyToEvent < ActiveRecord::Migration[5.1]
  def change
    change_table :events do |t|
      t.belongs_to :artist
      t.belongs_to :venue

    end
  end
end
