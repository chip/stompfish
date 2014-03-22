class AddArtistIdIndexToAlbum < ActiveRecord::Migration
  def change
    add_index :albums, :artist_id
  end
end
