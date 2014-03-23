class RemoveDateColumnFromAlbums < ActiveRecord::Migration
  def change
    remove_column :albums, :date
  end
end
