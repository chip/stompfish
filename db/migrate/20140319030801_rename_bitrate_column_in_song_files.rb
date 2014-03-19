class RenameBitrateColumnInSongFiles < ActiveRecord::Migration
  def change
    rename_column :song_files, :bitrate, :bit_rate
  end
end
