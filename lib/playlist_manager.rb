require 'formatters/duration'

class PlaylistManager
  attr_reader :playlist

  def initialize(playlist)
    @playlist = playlist
  end

  def add(song)
    collaborator.create(song: song, playlist: playlist, position: songs.size)
  end

  def delete(song)
    song_array = songs.to_a
    array_without_song = song_array - [song]
    recreate_playlist(array_without_song)
  end

  def insert(song, index)
    song_array = songs.to_a
    song_array.insert(index, song)
    recreate_playlist(song_array)
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
end
