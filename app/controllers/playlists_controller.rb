class PlaylistsController < ApplicationController
  before_action only: [:destroy, :show, :update] { playlist_not_found(params[:id]) }

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

  def destroy
    success = {message: "Playlist destroyed!"}
    render_response(success, "200", @playlist.errors, "422") do
      @playlist.destroy
    end
  end

  private
  def playlist_params
    params.permit(:title)
  end
end
