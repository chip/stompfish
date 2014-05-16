class PlaylistsController < ApplicationController
  before_action :resource_not_found, except: [:index, :create]

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
    action(@playlist, "201", @playlist.errors, "422") { @playlist.save }
  end

  def update
    action(@playlist, "201", @playlist.errors, "422") do
      @playlist.update(playlist_params)
    end
  end

  def add
    pm = PlaylistManager.new(@playlist)
    action(@playlist, "201", pm.errors, "422") do
      pm.add(song: song, position: params[:position])
    end
  end

  def delete_item
    pm = PlaylistManager.new(@playlist)
    action(@playlist, "200", pm.errors, "404") { pm.delete(song: song) }
  end

  private
  def action(json, success, errors, failure, &block)
    if yield
      render json: json, status: success
    else
      render json: errors, status: failure
    end
  end

  def playlist_params
    params.permit(:title, :song, :position)
  end

  def resource_not_found
    @playlist = Playlist.find_by(id: params[:id])
    render json: {message: "Resource Not Found"}, status: "404" unless @playlist
  end

  def song
    Song.find_by(id: params[:song])
  end
end
