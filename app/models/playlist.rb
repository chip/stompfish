class Playlist < ActiveRecord::Base
  # associations
  has_many :playlist_collaborators
  has_many :songs, through: :playlist_collaborators

  # validations
  validates_presence_of :title

  def play_order
    songs.order("position ASC")
  end

  def runtime
    SongFileFormatters::DurationFormatter.as_strftime(runtime_as_integer)
  end

  private
  def runtime_as_integer
    songs.map(&:duration).inject(:+)
  end
end
