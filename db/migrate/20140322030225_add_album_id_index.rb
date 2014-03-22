class AddAlbumIdIndex < ActiveRecord::Migration
  def change
    add_index :albums, :id
  end
end
