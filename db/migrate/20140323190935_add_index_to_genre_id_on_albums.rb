class AddIndexToGenreIdOnAlbums < ActiveRecord::Migration
  def change
    add_index :albums, :genre_id
  end
end
