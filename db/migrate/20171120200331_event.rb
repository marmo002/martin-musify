class Event < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :event_tm_id
      t.string :name, null: false
      t.datetime :date
      t.integer :venue_tm_id
      t.integer :artist_tm_id


      t.timestamps
    end
  end
end
