class DeleteSocialFromArtistModel < ActiveRecord::Migration[5.1]
  def change
    remove_column :artists, :website, :string
    remove_column :artists, :twitter, :string
    remove_column :artists, :youtube, :string
    remove_column :artists, :facebook, :string
    remove_column :artists, :instragram, :string
    remove_column :artists, :spotify, :string

  end
end
