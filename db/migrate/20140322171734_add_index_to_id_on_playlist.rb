class AddIndexToIdOnPlaylist < ActiveRecord::Migration
  def change
    add_index :playlists, :id
  end
end
