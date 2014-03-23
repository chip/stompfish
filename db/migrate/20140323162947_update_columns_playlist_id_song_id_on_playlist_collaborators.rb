class UpdateColumnsPlaylistIdSongIdOnPlaylistCollaborators < ActiveRecord::Migration
  def change
    change_column :playlist_collaborators, :playlist_id, :integer, default: 0, null: false
    change_column :playlist_collaborators, :song_id, :integer, default: 0, null: false
  end
end
