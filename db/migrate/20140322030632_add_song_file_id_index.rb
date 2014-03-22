class AddSongFileIdIndex < ActiveRecord::Migration
  def change
    add_index :song_files, :id
  end
end
