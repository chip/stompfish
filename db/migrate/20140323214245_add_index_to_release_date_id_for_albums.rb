class AddIndexToReleaseDateIdForAlbums < ActiveRecord::Migration
  def change
    add_index :albums, :release_date_id
  end
end
