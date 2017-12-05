class GenreUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :genres, table_name: :favourites
  end
end
