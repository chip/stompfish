class AddSongsColumnToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :songs, :integer, array: true, default: []
  end
end
