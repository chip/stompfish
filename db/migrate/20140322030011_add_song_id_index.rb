class AddSongIdIndex < ActiveRecord::Migration
  def change
    add_index :songs, :id
  end
end
