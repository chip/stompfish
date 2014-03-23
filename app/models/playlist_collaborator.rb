class PlaylistCollaborator < ActiveRecord::Base
  # associations
  belongs_to :playlist
  belongs_to :song

  # validations
  validates_presence_of :position, :playlist_id, :song_id
  validates_uniqueness_of :position, scope: :playlist_id
end
