class AddFileableIdIndexToSongFile < ActiveRecord::Migration
  def change
    add_index :song_files, [:fileable_id, :fileable_type]
  end
end
