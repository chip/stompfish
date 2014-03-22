class Playlist < ActiveRecord::Base
  has_and_belongs_to_many :songs
  validates_presence_of :title

  def runtime
    SongFileFormatters::DurationFormatter.as_strftime(runtime_as_integer)
  end

  private
  def runtime_as_integer
    songs.map(&:duration).inject(:+)
  end
end
