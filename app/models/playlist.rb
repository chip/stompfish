class Playlist < ActiveRecord::Base
  # validations
  validates_presence_of :title
  validates :song_ids, only_integer_values: true

  def runtime
    PlaylistManager.new(self).runtime
  end

  def songs
    song_ids.map { |id| Song.find(id) }
  end

  def m3u
    PlaylistFormat::M3u.new(songs).to_playlist
  end
end
