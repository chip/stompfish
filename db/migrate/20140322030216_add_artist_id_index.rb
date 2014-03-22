class AddArtistIdIndex < ActiveRecord::Migration
  def change
    add_index :artists, :id
  end
end
