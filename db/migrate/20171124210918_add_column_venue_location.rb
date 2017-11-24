class AddColumnVenueLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :latitude, :string
    add_column :venues, :longitude, :string
  end
end
