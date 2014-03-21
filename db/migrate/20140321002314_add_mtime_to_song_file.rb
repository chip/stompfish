class AddMtimeToSongFile < ActiveRecord::Migration
  def change
    add_column :song_files, :mtime, :datetime
  end
end
