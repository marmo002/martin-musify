class CreateVenues < ActiveRecord::Migration[5.1]
  def change
    create_table :venues do |t|
      t.string :venue_tm_id
      t.string :name, null: false
      t.string :address_1, null: false
      t.string :address_2
      t.string :city, null: false
      t.string :province, null: false
      t.string :postal_code, null: false
      t.string :country
      t.string :phone_number

      t.timestamps
    end
  end
end
