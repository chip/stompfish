require 'formatters/duration'

class PlaylistManager
  attr_reader :errors, :playlist

  def initialize(playlist)
    @playlist = playlist
    @errors = {}
  end

  def add(song: song, position: position)
    update_songs(song: song, position: position) do
      songs.insert(position.to_i, song)
    end
  end

  def delete(song: song)
    update_songs(song: song, position: :ignore) { songs.delete(song.id) }
  end

  def runtime
    Formatters::Duration.as_strftime(runtime_as_integer)
  end

  private
  def runtime_as_integer
    songs.map(&:duration).inject(:+)
  end

  def songs
    playlist.songs
  end

  def update_songs(song: song, position: position, &block)
    validate_params(song: song, position: position)
    return if errors.any?
    playlist.songs_will_change!
    yield if block_given?
    playlist.save
  end

  def validate_params(song: song, position: position)
    song.nil? and errors[:song] = "Resource Not Found."
    position.nil? or position.empty? and
      errors[:position] = "can't be blank"
  end
end
