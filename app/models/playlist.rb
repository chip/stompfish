class Playlist < ActiveRecord::Base
  has_many :playlists_songs
  has_many :songs, through: :playlists_songs

  validates_presence_of :title

  def runtime
    SongFileFormatters::DurationFormatter.as_strftime(runtime_as_integer)
  end

  private
  def runtime_as_integer
    songs.map(&:duration).inject(:+)
  end
end
