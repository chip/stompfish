require 'formatters/duration'

class PlaylistManager
  attr_reader :errors, :playlist

  def initialize(playlist)
    @playlist = playlist
    @errors = {}
  end

  def add(song: song, position: position)
    validate_params(song: song, position: position)
    return if errors.any?
    song_array = songs.to_a
    song_array.insert(position.to_i, song)
    recreate_playlist(song_array)
  end

  def delete(song: song)
    validate_params(song: song, position: :ignore)
    return if errors.any?
    song_array = songs.to_a
    array_without_song = song_array - [song]
    recreate_playlist(array_without_song)
  end

  def play_order
    playlist.playlist_collaborators.sort_by { |pc| pc.position }
  end

  def runtime
    Formatters::Duration.as_strftime(runtime_as_integer)
  end

  private
  def collaborator
    PlaylistCollaborator
  end

  def recreate_playlist(items)
    songs.destroy_all
    items.each_with_index do |song, index|
      collaborator.create(song: song, playlist: playlist, position: index)
    end
  end

  def runtime_as_integer
    songs.map(&:duration).inject(:+)
  end

  def songs
    playlist.songs
  end

  def song_array
  end

  def validate_params(song: song, position: position)
    song.nil? and errors[:song] = "Resource not found."
    position.nil? and errors[:position] = "A number is required."
  end
end
