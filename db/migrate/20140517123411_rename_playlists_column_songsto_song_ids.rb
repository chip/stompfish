class RenamePlaylistsColumnSongstoSongIds < ActiveRecord::Migration
  def change
    rename_column :playlists, :songs, :song_ids
  end
end
