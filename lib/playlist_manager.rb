require 'formatters/duration'

class PlaylistManager
  attr_reader :playlist

  def initialize(playlist)
    @playlist = playlist
  end

  def add(song, position: position)
    update_song_ids do
      if position
        song_ids.insert(position.to_i, song.id).compact!
      else
        song_ids.concat(song.map(&:id))
      end
    end
  end

  def delete(song)
    update_song_ids { song_ids.delete(song.id) }
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

  def update_song_ids(&block)
    playlist.song_ids_will_change!
    yield if block_given?
    playlist.save
  end
end
