class DropTablePlaylistCollaborators < ActiveRecord::Migration
  def change
    drop_table :playlist_collaborators
  end
end
