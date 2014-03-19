class AddValidationsToSongFile < ActiveRecord::Migration
  def change
    change_column :song_files, :fileable_id, :integer, default: 0, :null => false
    change_column :song_files, :fileable_type, :string, default: "", :null => false
    change_column :song_files, :filename, :text, default: "", :null => false
  end
end
