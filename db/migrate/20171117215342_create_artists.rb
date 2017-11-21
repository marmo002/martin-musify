class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :website
      t.string :twitter
      t.string :youtube
      t.string :facebook
      t.string :instragram
      t.string :spotify

      t.timestamps
    end
  end
end
