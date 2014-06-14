class PlaylistsController < ApplicationController
  before_action only: [:destroy, :show, :update] { playlist_not_found(params[:id]) }

  def index
    render json: Playlist.all
  end

  def show
    render json: @playlist
  end

  def create
    playlist = Playlist.new(playlist_params)
    render_response(playlist, errors: playlist.errors) do
      playlist.save
    end
  end

  def update
    render_response(@playlist, errors: @playlist.errors) do
      @playlist.update(playlist_params)
    end
  end

  def destroy
    message = {message: "Playlist destroyed!"}
    render_response(message, errors: @playlist.errors, success: "200") do
      @playlist.destroy
    end
  end

  private
  def playlist_params
    params.permit(:title)
  end
end
