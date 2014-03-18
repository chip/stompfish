class AddValidationToAlbums < ActiveRecord::Migration
  def change
    change_column :albums, :artist_id, :integer, default: 0, :null => false
    change_column :albums, :title, :text, default: "", :null => false
  end
end
