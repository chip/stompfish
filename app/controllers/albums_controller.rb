class AlbumsController < ApplicationController
  def index
    if params[:query]
      @albums = Album.search(params[:query])
    else
      @albums = Album.all
    end

    render json: @albums
  end

  def show
    @album = Album.find(params[:id])
  end
end
