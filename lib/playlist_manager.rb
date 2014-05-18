require 'formatters/duration'

class PlaylistManager
  attr_reader :errors, :playlist

  def initialize(playlist)
    @playlist = playlist
    @errors = {}
  end

  def add(song: song, position: position)
    update_song_ids(song: song, position: position) do
      song_ids.insert(position.to_i, song.id).compact!
    end
  end

  def delete(song: song)
    update_song_ids(song: song, position: :ignore) { song_ids.delete(song.id) }
  end

  def runtime
    return "00:00" if songs.empty?
    Formatters::Duration.as_strftime(runtime_as_integer)
  end

  private
  def runtime_as_integer
    songs.map(&:duration).inject(:+)
  end

  def song_ids
    @_song_ids ||= playlist.song_ids
  end

  def songs
    @_songs ||= playlist.songs
  end

  def update_song_ids(song: song, position: position, &block)
    validate_params(song: song, position: position)
    return if errors.any?
    playlist.song_ids_will_change!
    yield if block_given?
    playlist.save
  end

  def validate_params(song: song, position: position)
    song.nil? and errors[:song] = "Resource Not Found."
    position.nil? or position.empty? and
      errors[:position] = "can't be blank"
  end
end
