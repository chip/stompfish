require 'playlist_manager'
require 'song_search'

class QuickPlaylist
  attr_reader :search

  def initialize(search)
    @search = search
  end

  def save
    playlist_manager.add(search_results)
    playlist
  end

  def self.save(search)
    new(search).save
  end

  private
  def playlist
    @playlist ||= Playlist.create(title: search)
  end

  def playlist_manager
    @playlist_manager ||= PlaylistManager.new(playlist)
  end

  def search_results
    @search_results ||= SongSearch.search(search).sort_by(&:track)
  end
end
