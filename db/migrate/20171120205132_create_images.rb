class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :image_tm_id
      t.string :url
      t.string :event_tm_id

      t.timestamps
    end
  end
end
