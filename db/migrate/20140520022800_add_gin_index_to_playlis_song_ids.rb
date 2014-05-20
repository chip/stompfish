class AddGinIndexToPlaylisSongIds < ActiveRecord::Migration
  def change
    add_index :playlists, :song_ids, using: "gin"
  end
end
