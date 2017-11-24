class RemoveColumnsEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :venue_tm_id, :integer
    remove_column :events, :artist_tm_id, :integer
  end
end
