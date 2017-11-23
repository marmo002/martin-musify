class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :url
      t.string :event_tm_id

      t.timestamps
    end
  end
end
