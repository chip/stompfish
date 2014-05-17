class PlaylistsController < ApplicationController
  before_action :playlist_not_found, except: [:index, :create]

  def index
    if params[:query]
      @playlists = Playlist.search(params[:query])
    else
      @playlists = Playlist.all
    end
    render json: @playlists
  end

  def show
    render json: @playlist
  end

  def create
    @playlist = Playlist.new(playlist_params)
    render_response(@playlist, "201", @playlist.errors, "422") do
      @playlist.save
    end
  end

  def update
    render_response(@playlist, "201", @playlist.errors, "422") do
      @playlist.update(playlist_params)
    end
  end

  def add
    pm = PlaylistManager.new(@playlist)
    render_response(@playlist, "201", pm.errors, "422") do
      pm.add(song: song.id, position: params[:position])
    end
  end

  def delete_item
    pm = PlaylistManager.new(@playlist)
    render_response(@playlist, "200", pm.errors, "404") do
      pm.delete(song: song)
    end
  end

  private
  def playlist_params
    params.permit(:title, :song, :position)
  end

  def playlist_not_found
    @playlist = Playlist.find_by(id: params[:id])
    render json: {message: "Resource Not Found"}, status: "404" unless @playlist
  end

  def song
    Song.find_by(id: params[:song])
  end
end
