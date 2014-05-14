class PlaylistsController < ApplicationController
  def index
    if params[:query]
      @playlists = Playlist.search(params[:query])
    else
      @playlists = Playlist.all
    end

    render json: @playlists
  end

  def show
    render json: playlist
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params).save
  end

  def update
    playlist.update(playlist_params)
  end

  def add
    PlaylistManager.new(playlist).add(song: song, position: position)
  end

  def delete_item
    PlaylistManager.new(playlist).delete(song)
  end

  private
  def playlist
    Playlist.find(params[:id])
  end

  def playlist_params
    params.permit(:title, :song, :position)
  end

  def position
    params[:position].to_i
  end

  def song
    Song.find(params[:song])
  end
end
