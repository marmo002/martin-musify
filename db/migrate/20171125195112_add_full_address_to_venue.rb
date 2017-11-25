class AddFullAddressToVenue < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :full_address, :string
  end
end
