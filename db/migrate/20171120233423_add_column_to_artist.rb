class AddColumnToArtist < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :tm_id, :string
  end
end
