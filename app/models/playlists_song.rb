class PlaylistsSong < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song

  validates_presence_of :position
end
