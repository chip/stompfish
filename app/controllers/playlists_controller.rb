class PlaylistsController < ApplicationController
  include ActionController::MimeResponds
  before_action only: [:destroy, :show, :update] { playlist_not_found(params[:id]) }

  def index
    render json: Playlist.all
  end

  def show
    respond_to do |format|
      format.html { render json: @playlist }
      format.m3u { render text: @playlist.m3u }
    end
  end

  def create
    playlist = Playlist.new(playlist_params)
    render_response(playlist, errors: playlist.errors) do
      playlist.save
    end
  end

  def quick
    if params[:query]
      playlist = QuickPlaylist.save(params[:query])
      redirect_to playlist
    else
      render json: { query: "can't be blank" } , status: 422
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
