class AddFileableToSongFiles < ActiveRecord::Migration
  def change
    add_reference :song_files, :fileable, polymorphic: true
  end
end
