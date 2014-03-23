class RenamePlaylistsSongsTable < ActiveRecord::Migration
  def change
    rename_table :playlists_songs, :playlist_collaborators
  end
end
