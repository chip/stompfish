class RemoveSongIdFromSongFile < ActiveRecord::Migration
  def change
    remove_column :song_files, :song_id
  end
end
