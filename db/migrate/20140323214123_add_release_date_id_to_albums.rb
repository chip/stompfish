class AddReleaseDateIdToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :release_date_id, :integer
  end
end
