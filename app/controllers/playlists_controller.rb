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
    if @playlist = Playlist.find_by(id: params[:id])
      render json: @playlist
    else
      render json: {message: "Resource Not Found"}, status: "404"
    end
  end

  def create
    @playlist = Playlist.new(playlist_params)

    if @playlist.save
      render json: @playlist, status: "201"
    else
      render json: @playlist.errors, status: "400"
    end
  end

  def update
    @playlist = Playlist.find_by(id: params[:id])

    if @playlist 
      if @playlist.update(playlist_params)
        render json: @playlist, status: "201"
      else
        render json: @playlist.errors, status: "400"
      end
    else
      render json: {message: "Resource Not Found"}, status: "404"
    end
  end

  def add
    @playlist = Playlist.find_by(id: params[:id])

    if @playlist
      pm = PlaylistManager.new(@playlist)

      if pm.add(song: song, position: params[:position])
        render json: @playlist, status: "201"
      else
        render json: pm.errors, status: "400"
      end
    else
      render json: {message: "Resource Not Found"}, status: "404"
    end
  end

  def delete_item
    @playlist = Playlist.find_by(id: params[:id])

    if @playlist
      pm = PlaylistManager.new(@playlist)

      if pm.delete(song: song)
        render json: @playlist, status: "200"
      else
        render json: pm.errors, status: "404"
      end
    else
      render json: {message: "Resource Not Found"}, status: "404"
    end
  end

  private
  def playlist
    Playlist.find(params[:id])
  end

  def playlist_params
    params.permit(:title, :song, :position)
  end

  def song
    Song.find_by(id: params[:song])
  end
end
