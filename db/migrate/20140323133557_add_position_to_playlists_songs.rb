class AddPositionToPlaylistsSongs < ActiveRecord::Migration
  def change
    add_column :playlists_songs, :position, :integer, default: 0, null: false
  end
end
