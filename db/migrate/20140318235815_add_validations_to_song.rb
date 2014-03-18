class AddValidationsToSong < ActiveRecord::Migration
  def change
    change_column :songs, :artist_id, :integer, default: 0, :null => false
    change_column :songs, :album_id, :integer, default: 0, :null => false
    change_column :songs, :title, :text, default: "", :null => false
  end
end
