class Event < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :tm_id
      t.string :name, null: false
      t.datetime :date
      t.string :venue_id
      t.string :artist_id


      t.timestamps
    end
  end
end
