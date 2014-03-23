class PlaylistsSong < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song

  validates_presence_of :position
  validates_uniqueness_of :position, scope: [:playlist_id, :song_id]
end
